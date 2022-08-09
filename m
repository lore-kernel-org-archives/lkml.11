Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB4C19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbiHIIrX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiHIIrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:47:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C668322288;
        Tue,  9 Aug 2022 01:47:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z3so8272500qtv.5;
        Tue, 09 Aug 2022 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=J7QbzOr78YImnozlEAsmvj0GITL/0KLYvwQdpUC74wM=;
        b=aWGRKCVYu0Q780Tz20w+c8PuqoCkT7/rV2IqdEKAGrOjH0iXGV/BppkWmq83OPej85
         BWUSrIUqzAs5+gqkJC21x2eD8WOhKg4xBKr1YS7ds04sqa8uVvhHD0c0MVVUmnQ5hErd
         etE+izzdWZzGat9Ue4D9g7suoRMgfKwJtnMbj/fewxzEBcHBXoSo5J726NjzJ0X+xyym
         1cbOPgM5fXdG3Ij+yOEHYLPyUcO904cmOWbVSel+gJVtf4P5BXsI6DDctVFrdNc8zH3O
         hwLWKqQnd/bx3n98U9YfDyiKAADj0kxAwPih3T4UX9s0KFB6KoqVv+zQrfp1Xqh36EiZ
         luFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=J7QbzOr78YImnozlEAsmvj0GITL/0KLYvwQdpUC74wM=;
        b=3ptrGA44i9CvStrM953Pss4zlIabIi9E9z/qU4KUhcCEmfge3TJYB6DjibhEO7tkkQ
         opwKc1w76h2CF3hoHjtqDy0esdHipQMlwbxBuSyIz0L+CrcP10PBP2c0v9O+pUxzLZ2C
         UtHDsikuU9I8JHdt0hkGJdFNoP7RiQsij+sqmekBwB2Zmwaw3XCMllJiipVnpCXDstNG
         de8ndn+bL9d4CFjIsHpKEwuQFFtXr88I0CBN6lvCiAo2JWre522/qBJkuFn8XlacyVD+
         dpEkZIwck22indU6Xv27hOtz/NLt2S3qkuI+U2qLTYIkT6Y30qUX+oXMdc0X6OHayhGb
         EXhg==
X-Gm-Message-State: ACgBeo1j6kZMx7mrEp6mnv9jQSHadMWTJ5SokWeKFZUZwN4f5Om341NW
        KeTjXqIMo7Jlm1A0pzVostczt/hqUBPwyb4VrLHqP4Wp1OY=
X-Google-Smtp-Source: AA6agR69BSaNFrvRPepLkeCtXKVS+IWbFvHVrHfKQrR5cysHhHaiUDTRjhW7Ob2d7aASUdsZPCpAqJP5J6dZZ17PJEA=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr689135qta.429.1660034829827; Tue, 09 Aug
 2022 01:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220809025054.1626339-1-luke@ljones.dev> <20220809025054.1626339-2-luke@ljones.dev>
In-Reply-To: <20220809025054.1626339-2-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 10:46:33 +0200
Message-ID: <CAHp75VfZeuuQjfM+CY4nxrFJQcfpdHVVzyj6GLjeweT3ycSn5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB control
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for TUF laptop RGB control via the multicolor LED API.
>
> As this is the bas for adjusting only the RGB values, it sets the
> default mode of the keyboard to static since there is no way to read
> any existing settings from the device. These defaults overwrite the
> booted state of the keyboard when the module is loaded.

...

> +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
> +                               rgb->save | (rgb->mode << 8) | (r << 16) | (g << 24),
> +                               (b) | (rgb->speed << 8),

Too many parentheses.

> +                               &ret);
> +       if (err)
> +               dev_err(dev, "Unable to set TUF RGB data?\n");
> +
> +       return err;

How ret is being used?

-- 
With Best Regards,
Andy Shevchenko
