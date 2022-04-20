Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 22:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382967AbiDTWrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 18:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245190AbiDTWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:47:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C05E2B186
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:44:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef4a241cc5so34355127b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biQCpdNqt9EOdNzfaHDH0wXEREY4vMB2K+noZnpNvLk=;
        b=nx9H6BpSgpwEF2wWC4PiwzkFKcfePbpZyW7Y/ioyrB7zH3fR2hVJ3jP61Q83EkQOVf
         uqz/nEKYIaSyferNkUQEqhgguM6ai2UqxzvBbHqJKTAjIZM7dapFIroSb5TQAJfztSzl
         znZ0XvpeJSe4qc3AXfwezdaBF1FxV/RtMW/SZKHCr4cZjDKiM6zZ7tseDOQFKrEpN71Z
         kbEOCSdp7IXDxK2hrCp577+J9wr1zGaIGA2sQcSrrnQm2GihN09ysTmXlsFuXctNCxGc
         VvPQqbemiGA8XBxBSFF2WrLbYpJGis+6K0SeP7bZ3RjxixBbKigdNmVWAemfFejCRilL
         8Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biQCpdNqt9EOdNzfaHDH0wXEREY4vMB2K+noZnpNvLk=;
        b=fgZLiYiqciHQyIGA78wqDEWI8M/0y//Tbili1pRDzXO9U8jmSSO6u+W0TOaZEb8myN
         8NILEofP3UWZKUKAKCJheZTpAikhOua1jHg1UvLRpnMWXTUBARzBWA/5jqJpcEoD6CnV
         JvqndeTLWTWJQY8DqEQkjCvdYIL2I78PW6SP0oP8TG2BPeoQmwgfVO8tAG0Y89D6SuMF
         ZSHERkuqNEbNltmhsvLulpYv9QqOSQd6wrJg0dUGb5zU1l5WjLF8ucdFfph8Gdc7iDG0
         tfa2x60+d/W93R8riKIRU2N+1ZGAr+RggEe0NfhOIGTAuRn149fsowJS2GuCf8CqSY+c
         9TJA==
X-Gm-Message-State: AOAM5333XgQ5yD25uPreNQt1TlBW3QMY4HsQXIxF62KCD+DGzKWMvQ/Z
        PqDBt8M76NEkfjtTv58iYgqgWUo6mSLr97JiSB8MbCcG9LA=
X-Google-Smtp-Source: ABdhPJzF3FvLViXjWfev1hwRIHaerfHNAEFSRiDR07ODCQZKYbqJ/OG2lTs7Ul6E/bd3pAQDeY+Ar6m5rRgqx6vZmQ0=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr17254983ywd.118.1650494663286; Wed, 20
 Apr 2022 15:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220407202509.23228-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407202509.23228-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 00:44:12 +0200
Message-ID: <CACRpkdaR5Oa8=WQtrQwwZVv7AU3AKpKk37L5upe1+tPq3R=acA@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: max77620: drop unneeded MODULE_ALIAS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 10:25 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The MODULE_DEVICE_TABLE already creates proper alias for platform
> driver.  Having another MODULE_ALIAS causes the alias to be duplicated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
