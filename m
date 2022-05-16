Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 10:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbiEPKZp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 06:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiEPKZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:25:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C711A1A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:25:27 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r27so15386129iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wi7FZ4sQpiYFKSAT45PbkZoAgmyf6uUSxphI+SAE7xg=;
        b=gExCtsIsHo4jDqSh1oIaaQMB/SVgN1TgdoLWTbuBqlwADdC4X8/BXUu0W5pAsIbnuB
         Gd/lIj0KUexSKmCA6VgMA5qw0Kp80B8oD++5zkRiD1X5kn70tlwr8pOM8HKCaPgJpZod
         hVCcl6MZZajGoz5v/sH7W7trFYcCi0WK4tPqbHNTRsxxQyivr4dYEzu+tgvXPYXOzrk8
         hZcIPvbUEEEl7+dIEQMujSm2xzHvye0fTzRpcGSJBYt4JbZVMeEOT5yMn6Rm3sr9rwVD
         GSPgTZ9358/8ti/Vq3+MyAbtWI6VESWFHyxGEE3yK5dHhlPRlQ9D6yGDrvYSAVI7XABI
         R7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wi7FZ4sQpiYFKSAT45PbkZoAgmyf6uUSxphI+SAE7xg=;
        b=2jJp/sMKBzAR9Hj2ArI94kjwecUVtklSGc1BvlZ3WcLKhmSR3M4Sii8hGGKc7dmHPa
         n/iZbNtCCRCTZTr/ZXcGz2geCy6jYRrzDzp9rBMogpeUXFj9PPd0BrqvYFUr7ujYDpZQ
         WXSbcUnCJI9O7vOqxx0Dh0pcSrYxPYIPMdSebkRouLGP2AhvdDsdtpLUYZP/ZU9xXZ2j
         yDbHbYhw/zG9EO7YrT4lOnOqNAPDUgHDmd71oXjLA+Q+NpSXHtWLjMH0NhfYo1ukA2Nr
         m0vVb4uY6i7E86meyyfkhPjZ/R5whSem63cixfL6DFNyKzK2RwSSFbzKYu/rOiztp8qy
         vmTg==
X-Gm-Message-State: AOAM5314PlZVv0Os489JtHFmmIk6XNwsjtwzrTypD7Es8NA2x5vl1FG+
        DSHN7wT4s74ILomfMPTRb4cPgLK2LHYIE17L7AKFkA==
X-Google-Smtp-Source: ABdhPJxw5zlT4NJpzsyi5yIx3XxcoNdxQbi+F3voNa3E3vqfR8SegU6lhQZA3QYcoF2h5lNr7l0dDXMuGhUcC7d/92g=
X-Received: by 2002:a05:6638:450a:b0:32e:1bd1:735f with SMTP id
 bs10-20020a056638450a00b0032e1bd1735fmr4119326jab.145.1652696726666; Mon, 16
 May 2022 03:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220516030251.42323-1-schspa@gmail.com> <20220516030251.42323-2-schspa@gmail.com>
In-Reply-To: <20220516030251.42323-2-schspa@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 16 May 2022 11:25:15 +0100
Message-ID: <CAKohpokHFd=EAOXvpecde=QRGEq8Ek+P6UsLjfVDrW0nOspuFg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpufreq: make interface functions and lock holding
 state clear
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 at 04:12, Schspa Shi <schspa@gmail.com> wrote:
>
> cpufreq_offline() calls offline() and exit() under the policy rwsem
> But they are called outside the rwsem in cpufreq_online().
>
> This patch move the offline(), exit(), online(), init() to be inside
> of policy rwsem to achieve a clear lock relationship.
>
> All the init() online() implement only initialize policy object without
> holding this lock and won't call cpufreq APIs need to hold this lock.
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
