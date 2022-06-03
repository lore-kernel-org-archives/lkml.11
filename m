Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F259C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 13:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiFCNWQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbiFCNWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:22:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BC51055B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:22:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so10407156wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGU+Xu8QDUfq/qo2/JU9T5aRAydFmE44aLPRPpmDV8U=;
        b=UTDloxPKOiYzDyUa4exszRUCqVRxzJPdzR7cknbEoHq7XBiOIj0oHC6t73uaYPSP/T
         6VEe1fRJj9ccZUTrmblRlhaCP3y0+BWGj4rcZZQ4Wn2+/zqxSIv4XTC973xIXU5zWlbZ
         SjZ4J0CuHQNh2EzL0HT1I8ATLbmAwpYth6amCF0yooDSCXeXW7Q++5KtNIczOn+zBqVP
         lSEHKjCo2ryOcSXz9sBOXPz359ki+Z8zoNZPU4Wepk0ftTAayPLH/Kt9WIVhFj2Sg60J
         sc0q/PPymEReagx60muboLoUooBz4yUS92MBPeYxU22tMZqzHuElkK9PwJAn4ffikQ4x
         Xyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGU+Xu8QDUfq/qo2/JU9T5aRAydFmE44aLPRPpmDV8U=;
        b=r3gdT2ez0SM/LVoyiPQZC+LVcmmLO9xMLNKY6HngetCbMnVb7xUo1d79bjbB+NNe6b
         67FgmmIEzRcKP5QecFDH9WIbmaGGMgy62C4deFW0LHMZ7CuYwmu9ugLT60TvceEL4GMV
         1CXcJw8E2QSRdd6N+9TBh+1gnXc7OMi1AAkuLjNy4834dxIGXP+CBnjAGVJlGxhMv+jn
         QYYUQW/J9dQYi5VgZ0hdjCYDsWRH5nu3XHjizoxJyKrdCPEQX2oqtU4EewJkYYjnQPC8
         5NMIIKADSi0a/55Ox+B7KBoV787+/vvhtveQ+MqpCnERRMC5UUz7V+BuE3ibwevusw2r
         YeyA==
X-Gm-Message-State: AOAM532sZdjU9uhJN86qT1faNF4rGQW+nIPZk/RWFywMLV0gzgw838R2
        OU2VGvhd1IO2pzE4upeKEB6Id11tzHJyMs4Q6tDSFA==
X-Google-Smtp-Source: ABdhPJz2bpzIiIssUgyGi+Sj5UOIu8e4KPDKeIwrTx/ae2bYxb3tVplj+QXqlERXujmxxeO3ewzMP8IHP2lRQGiEiY4=
X-Received: by 2002:a5d:54cb:0:b0:213:55ab:cecd with SMTP id
 x11-20020a5d54cb000000b0021355abcecdmr6411216wrv.374.1654262524691; Fri, 03
 Jun 2022 06:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
 <20220603124956.GA18365@lst.de>
In-Reply-To: <20220603124956.GA18365@lst.de>
From:   Michael Schaller <misch@google.com>
Date:   Fri, 3 Jun 2022 15:21:28 +0200
Message-ID: <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
Subject: Re: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Christoph! <3

Patch https://lore.kernel.org/all/20220527055806.1972352-1-hch@lst.de/
does indeed fix the issue.

Could this patch also be backported to 5.17 and 5.18?
