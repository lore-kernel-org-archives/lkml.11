Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C9CCA473
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 10:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiFCKNg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiFCKNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:13:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29013B03F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:13:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e184so12895553ybf.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94ZegRhkYg/saXV+SmkOjrIFO68BuJxSlLGLu4NRWgI=;
        b=cWnKkwPusG0TKPrwdSeL9GfiK9qV2jq8XHQI841ZQi14sBambMQZLS563NvaLZElf2
         75115UwtrmhkAHVhZHmiunsBxqODjE2sgZG5RZUUttFd/XjwT9ELF81y1MF+VjPTBsXy
         Ecc+OxP4Ug9Nkq1KWYx7PsS/8LdlHSvr8pmzuBVF4JJSNw/zCKM/57awLBnHtRJH+URJ
         ivbdaF8SKbVQFRj++AP6rq74w+ppYkrOD3IrIlaZnu3m6qTtGWAs0bfx8BngaVgPvKTf
         vdUOkox69Qac8HsvfBibu1f9UhbH8lmh5VamMeFlCaOhbP7O16w6ZyMfyL8EpGm81ssR
         AiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94ZegRhkYg/saXV+SmkOjrIFO68BuJxSlLGLu4NRWgI=;
        b=fZ3rw4NZmbxREwSfVFwEtHI7FMVsZDOcKvypieMMhuv08bO0dGzbztaRGElpoIE+7O
         RPAZy7m3XFJUuuOvrf7u79fpAHCzKZvhGWVaya4cB8oVxvlguXQwfhKc2qipYAmQ0KH5
         vrRQpc/nFW0xZ/l5cSXwiGW5W3AyICY4ds7MPNPrjGq6xY61Nm8RQ/yPtbPw33tTWm1K
         JvrH4HrXU9LYiEt7O21X0EUKjGy+YaeoSJIcZRHnEolrVLy/BBFXgndQCPNhCGJXizlV
         W2jrTt4879eezsLagm00WWzGuv7gBgCrNOG6i4HRJ8WcYq/dxJTPaKwppbA8SkfxNeMI
         nKqQ==
X-Gm-Message-State: AOAM531cQ9Ockidwqw9A/CCmVRc4qzNuZad+JSNIODQn/kTqtUClh13P
        c/1A0EomKVeAa1ifsak4s5m4oWQCM4mRWgveQbQRXQ==
X-Google-Smtp-Source: ABdhPJw/KRcAuBS5Qsp7lOCZIpBhbUKTpsBgops20ECaxi3YO08dKdMkgM9KLeB4ACdlmuIwzLo5Lgpc34BZ5v0Gd3Y=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr10098240ybp.492.1654251210044; Fri, 03
 Jun 2022 03:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <1650508019-22554-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1650508019-22554-1-git-send-email-baihaowen@meizu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Jun 2022 12:13:18 +0200
Message-ID: <CACRpkdZPZ5fNxt3=LCT4YRcnH5wNw+i50dde_eQGynzK0FCXFw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Fix potential NULL dereference in aspeed_pinmux_set_mux()
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 4:28 AM Haowen Bai <baihaowen@meizu.com> wrote:

> pdesc could be null but still dereference pdesc->name and it will lead to
> a null pointer access. So we move a null check before dereference.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Patch applied, sorry for missing it!

Yours,
Linus Walleij
