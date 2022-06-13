import { ExecutionContext, Injectable } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Injectable()
export class LocalAuthGuard extends AuthGuard('local') {
  async canActive(context: ExecutionContext): Promise<boolean> {
    console.log('use auth guard');
    const result = (await super.canActivate(context)) as boolean;
    await super.logIn(context.switchToHttp().getRequest());
    return result;
  }
}
