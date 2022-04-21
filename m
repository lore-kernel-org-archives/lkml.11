Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E58C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 14:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389079AbiDUOSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387806AbiDUOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:18:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD520F69
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:15:55 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id g14so5647475ybj.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdhV5xJb3yTPG4IXlt4NbO27rLVO/vJmiWIV9V5oqiQ=;
        b=QwIlmWUpQAd4v0AjUgLjg4oebC7z6SlfN1pzB8lJ2uZzt9wKTBXmNQNnf2wTFBzaf1
         8QXh+7UYxlZXMu+6u2wZfndNkIgETSoRrX/QSAOx1E/EfpLAi1npmM714RsC8Xzp2+r+
         J5CbgX7HFziZZmxDNZYbWRhNQqIbi1hpqrcia56Ez8AeKzRHLhM0HnfGNYRTkGBf9DL8
         UVOnY/dOuT7Q8lQqakFBFBRAcpokcWTWFa0HF0M+uvq9dAdKKeauC4STq6WqmVoYawks
         ePZ0/fkpos8Nz4LpXQ3tJA0IbRBWxrk2cju/hmkKzTZ/jaBz8N303f0JEq9jfnBPBS1J
         dvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdhV5xJb3yTPG4IXlt4NbO27rLVO/vJmiWIV9V5oqiQ=;
        b=NFEWepx3wHWIBIU3OctS72Hd5fXZRiQNV1GpBIXqjM9LauZEzngbnrjCf9JGrVtIEH
         iDbDmxfHbTnggeG/8UInx0XDQn+V7TFH4t8mRM/l8IRF6ASzvNvmM0Iyx1/5lWIo+uLD
         TjnNThaGHwTPu0EI4cJfK/Gk3b7kvdHRgRL8tEETrCPNFE3+LUxWg6K2Re3bHH+xfqkT
         icaImgGMtz3+S/+Wn2cMdASQQYLsvGAos51uwIk5ogROuC9AVgu19YzVjsM53ph9r+KY
         g3C7BBJn8CkNv4s1z9hXDXvfj2bGRYgBdYp15NJBEENOXVs8F4fgdUirJFLkbhOx0h0U
         xmTg==
X-Gm-Message-State: AOAM533w2Vgk4JitgVmVMb7+H6TW1JPXyClbZDf6fLsvhYZ1rJcDIstK
        XHcCFy+JAckiVHkUzKWjsBI9V4CogVnPDNmV0NleuA==
X-Google-Smtp-Source: ABdhPJy2/9TEWKOJgrsxEaZAHrf6O4u8qAdfriJlxVUrx8dcunjMApUx6rLwWisom0mmM9vfeNhIq1T4qtZQHMmo8ZQ=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr25169549ybr.295.1650550555204; Thu, 21
 Apr 2022 07:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220412162218.32509-1-paul@crapouillou.net>
In-Reply-To: <20220412162218.32509-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 16:15:44 +0200
Message-ID: <CACRpkdY2L78n5_SB7tLNdyyxrYq9Thx=P4V4e=JmqGA91wqqww@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: ingenic: Garbage-collect code paths for SoCs
 disabled by config
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@opendingux.net, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 6:22 PM Paul Cercueil <paul@crapouillou.net> wrote:

> By being a bit smarter about how the SoC version checks are performed,
> it is possible to have all the code paths that correspond to SoCs
> disabled in the kernel config automatically marked as dead code by the
> compiler, and therefore garbage-collected.
>
> With this patch, when compiling a kernel that only targets the JZ4760
> for instance, the driver is now about 4.5 KiB smaller.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied.

Yours,
Linus Walleij
