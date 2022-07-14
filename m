Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84562C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 14:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiGNOaB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbiGNO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:29:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1845C95C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:29:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id va17so3833683ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1X87mQYG95YA6ZZAAKldNH7qg7++iZIilnL645FgaYE=;
        b=PTDNmnzInPFykguc6N2+FlL1QMiTDe4AYkk6DNFVUa24DeXwL+7HiVkfBqWKNkUGv+
         h10SXjpEZiFr6VFocoA1GetnziVXgTZgmdUHXxP1AQGjtpbpTZXOI1JG2FYPp6+WmTAl
         1hZ2ObiE1+gmVGiT6t8GIp5VSG5vfdeyQy03+5AXgDT4yBWJWveIGxAPloaw0pbn8+fv
         Hcw9+lZkbxzTckXwE9OiUwUl7p1GpusnJC6UPqLJjVMsuFOV8vlKDTdAJ6JwYrb1Nufk
         7d4wz2oewvVrJEOcN9qLxF3qc1wumIMmuIX/fCAn/4sZgyKOCAtX7l/JSf3MwN89fkD8
         mKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1X87mQYG95YA6ZZAAKldNH7qg7++iZIilnL645FgaYE=;
        b=cj6j1iwMrQ0DDjT+qArZIcH9uS8ncIjRsVG68M1+4Y7jOieSLqMx1OoYXLV1om5nDO
         lYVLU6EkOLSkqOBVCAbB1mGFqsL0DjD50aHwTQCd8qR76v7WjXEC4yEhG0KSEVTvB8d0
         fTazo48dHxS4WiLEcykmXc9GyeiPBxuVt4qZzIaU79mQAOIwRognBbVO2KFDwSsvtSch
         BBKIiCdHnvOzzK0TsIEjTzublgzOv9I6NchbR+FcMRjliZY0WsB89IEa+/IHZHtu/iWH
         /ZgtQ4sjiTvsxYFDYWYzgAQmJBN4csRJxI+cziK9TfJTUt8np8ijDAwvr+wWSm00Sq2H
         zCGg==
X-Gm-Message-State: AJIora+4lTqjVIsqrIC+gscLdQuusZJQ3VpQlLJCSknR8q0S4bjFMoH/
        dATTcHlQ5fgk18nJTaDxZod/6OtY0HzUY4ny2QJqdw==
X-Google-Smtp-Source: AGRyM1vm6GjtZHoqF4hgzMx23b5BRicpYtS2WOByyw2qG698rE5P4eoixnC2wpbC9PRCXQZPg9NBRFVR38jt6MQYFYE=
X-Received: by 2002:a17:907:720a:b0:72b:549e:305a with SMTP id
 dr10-20020a170907720a00b0072b549e305amr8680576ejc.691.1657808996109; Thu, 14
 Jul 2022 07:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-6-tzungbi@kernel.org>
 <CABXOdTeC+q-UiPiThqL5MGg-+cGACGW4qLaLKZbmX4M26TvbDg@mail.gmail.com> <Ys+OlrVCy4MkyRnr@google.com>
In-Reply-To: <Ys+OlrVCy4MkyRnr@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 14 Jul 2022 07:29:45 -0700
Message-ID: <CABXOdTfJ6x5ePkmj+w21jTX7EOTXZrCd8PwikAJQTfeQmUBxaQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 05/11] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 8:33 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Wed, Jul 13, 2022 at 11:15:47AM -0700, Guenter Roeck wrote:
> > On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > -static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> > > +static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
> > >  {
> > > -       int ret = cros_ec_xfer_command(ec_dev, msg);
> > > +       struct cros_ec_command *msg;
> > > +       struct ec_response_get_comms_status *status;
> > > +       int ret = 0, i;
> > > +
> > > +       msg = kzalloc(sizeof(*msg) + sizeof(*status), GFP_KERNEL);
> > > +       if (!msg)
> > > +               return -ENOMEM;
> >
> > AFAICS this is always 24 bytes. I would suggest to allocate it on the
> > stack to reduce overhead.
>
> Ack.
>
> > > +               ret = cros_ec_xfer_command(ec_dev, msg);
> > > +               if (ret == -EAGAIN)
> > > +                       continue;
> > > +               if (ret < 0)
> > > +                       break;
> >
> > With the command allocated on the stack, this can return immediately.
>
> Nack, the function has no goto labels.  `return ret` follows the loop
> immediately.  The `break` here doesn't make it to become too complicated.
> I would prefer to keep it.

Sorry, you lost me here. The code after the loop does

           kfree(msg);
           return ret;

If kfree() is no longer necessary, only the return statement is left. So break;
is identical to return ret;. Am I missing something ?

>
> > > +
> > > +               *result = msg->result;
> > > +               if (msg->result != EC_RES_SUCCESS)
> > > +                       break;
> >
> > Again, this can return immediately if the command buffer is on the stack.
>
> Nack.  See above.
>
> > > -               kfree(status_msg);
> > > +               if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> > > +                       break;
> >
> > Can return immediately.
>
> Nack.  See above.
>

Really, for those I think that
                   return 0;
would be better and more explicit.

> > > +       kfree(msg);
> > > +       return ret;
> >
> > What should this return on timeout ?
>
> It returns either:
> * -EAGAIN, if cros_ec_xfer_command() returned -EAGAIN
> * 0, if EC_COMMS_STATUS_PROCESSING flag was on
> for EC_COMMAND_RETRIES times so far.
>
> This is a "move" refactor.  I would prefer to keep it as is and change the
> behavior in later patch.

Ok.

Thanks,
Guenter
