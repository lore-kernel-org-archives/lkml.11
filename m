Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAABC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 18:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347501AbiDRS5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiDRS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:57:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0382FE51
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:54:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t11so28418031eju.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QGbAt7FqzrbpTv/n51B3Z6/0bd+lcDV2V2eKLni8zo=;
        b=IuE4ssFXtlEcJ+zZqWTmEb+4bHaWkQLmNM931wGQ6o83URXG989L2IEDKlKOX4YsWu
         ZyMA1cpRPICnTD4ePi8p/FbiyQxIrCL+0SgqYBy6y8soFjFDz7JsHtl7aKxxjEgoYnf9
         o01uJGUz38yya8+NlKuBnZFoetdy8tMdB+5Y+L2W4DOfyA9AXJ1gMh18PdFWxJ6cvq44
         XGMcE6cZohSVdJlkYQC7i0Q2/l4XaX2lYCqp5IBtNhfsVR0G4ZhQ1h3LpP6PF/gjhEYv
         kepBdjW5vFoy279VO5k0g1dWBGyoc8zm7UAPxomXZMyLUgiAJ9gf5bDtvTCbkgLzsOGe
         RwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QGbAt7FqzrbpTv/n51B3Z6/0bd+lcDV2V2eKLni8zo=;
        b=3nvocK5wFdow41X76g2bYjbg+W3Q9qf1E/8kgi/RMHQEbMzQFA2War7Gt9zG7w+GhV
         N8rfB0iUU+c4ElVesMxPixoceKStY8nNFny52G8v+X8uutNG/yObgQDY4izi1lwQ/wsy
         UP0GvY3YTLgsyaCaVdujlxpbyKFXEH0f6ywWDbsPl4sjntgkBtUjm238qHZyjzPS8BAn
         /bDLtsqW9R/v1gbIEFKIXS/XFBFZXc0N/l7qZG2tDC6Q0HW9RII6R8uDXjQfY5tjYDvp
         FtytDvPpax5pcUA5MYaUldYPGZrYGvl60PBTVLMWQFAgEc1o/Mp5aGFjBfWKJgdhmVl5
         SsoA==
X-Gm-Message-State: AOAM5310OVHYb7aOycVwfLUXViXUg3xj55hDqUKnAa48l8dsdnDzznk0
        3V1Nqbsubv4wJVJXdvcDvvP97+CtsZunkyoSC4fbrA==
X-Google-Smtp-Source: ABdhPJxwYXie8oTEuzmUOLcCEWK9RrfrzY4Rc5T0c9iK67wNPu/3BoRmK50VPIoiHQ5T6Tz8/wzP6Vvy9+umKpTzUUg=
X-Received: by 2002:a17:907:6d90:b0:6ec:9e1:865 with SMTP id
 sb16-20020a1709076d9000b006ec09e10865mr9924132ejc.369.1650308062748; Mon, 18
 Apr 2022 11:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220405190619.540177-1-dlatypov@google.com> <06087446-c053-7099-b8f1-40a467781186@redhat.com>
In-Reply-To: <06087446-c053-7099-b8f1-40a467781186@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 18 Apr 2022 13:54:11 -0500
Message-ID: <CAGS_qxqFqM=4w1xEB_bmznMAh3r19Ou9TjYR8gGetG1ypo7W5A@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
To:     Nico Pache <npache@redhat.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 1:43 PM Nico Pache <npache@redhat.com> wrote:
>

<snip>

> I have tried posting something similar in the past!
> https://lore.kernel.org/lkml/f427ed5cbc08da83086c504fbb3ad1bab50340cd.1618388989.git.npache@redhat.com/

Aha, so that's why I vaguely thought someone had already done this.

>
> Reviewed-by: Nico Pache <npache@redhat.com>
> Acked-by: Nico Pache <npache@redhat.com>

Thanks!
