Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A361C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiECTc5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 15:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiECTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:32:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B22B184
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:29:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so32049188lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vrL7XkKPM/fDDKM+WseGESNouqMD+FfUqKoaeNFxXOw=;
        b=XWuECTjXnwuPdrZllK4DeqHBBkqyK3F/k+4xtX/o3AuWklbUoso8ijNsaXpy6IQ+c3
         UdH1qbnVvBOYesa2R8E8Fpzlfq5bg3X7qQvGtEFh8LGYWaI/+RJRLncOt0+Nzw24WAka
         gVzRyloeN6KRSicVJH0VDKzgBzes8xrfDMcENHbvJ4HseJkNQm/DuVjElzOgm9FlnsX7
         nCcGIbiFmqeadeJmgsw8mXjzjUPDTq+9NaQOEAbzNIMtAIe++NFEUN8WvCptDH2wUTFG
         Lhtay5xL0CajMIDc0XtfXBal2lZoxjafp+p6eje9z7wqINLTqp9MAYdzN506ksRmajIJ
         DIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vrL7XkKPM/fDDKM+WseGESNouqMD+FfUqKoaeNFxXOw=;
        b=6CR8VX7GVdduGihlOfg0ZyXxPGb4xwPB5qjpwjCrTstG3Q3a390NHzFIK8tNwkztaP
         bxPpwXMTOJhGF/cJAhU+qRnqY7C8JSgL85EbUwbFceiT05D1kPsKNEh8MR68EwC6K7pA
         Shb+Lb/fmc4S5mkUD7VrmAfsxNL79A2nctoINKZk10ywLO5Q2sSfNUU3vNGvXBXkfV8U
         zFo06U6LFEKKr+S5qhVFTPbcQA9sCEBQuc3xqpxxuFMHh4SEkLsybCpSSXjxvDvFeMSo
         kGYk4hj1xZf1OYw1KJBV8xWvSKPPIm2To56ANeV+WQp8t9esDX/Mtkvo1nLVHX8RMHrG
         riAQ==
X-Gm-Message-State: AOAM532OYUTDcyNTWP/NPuT265zgfz9hPHP2CADiY4OL8XyhhVR62qK/
        BoBdrJlc6onyVJjuAkb9AvVmL4ayxyUWog==
X-Google-Smtp-Source: ABdhPJzf6t1KXZQ7VbgFSHWEP9s4rPmvnO49pd4XQDm0Sr89zB1DbHVlC9wf5jwU+tibSOhz4uCZ+Q==
X-Received: by 2002:a05:6512:b11:b0:44a:2ead:daf2 with SMTP id w17-20020a0565120b1100b0044a2eaddaf2mr12201966lfu.642.1651606159560;
        Tue, 03 May 2022 12:29:19 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id a8-20020ac25208000000b0047255d21161sm1015104lfl.144.2022.05.03.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:29:18 -0700 (PDT)
Date:   Tue, 3 May 2022 21:29:16 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE SHM vmalloc for v5.19
Message-ID: <20220503192916.GA3288817@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this patch which enables tee_shm_register_kernel_buf() to
accept vmalloc()ed buffers.

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-shm-vmalloc-for-v5.19

for you to fetch changes up to 3e47235eaee09488c7e467b9aaccb7c93c862c6b:

  tee: make tee_shm_register_kernel_buf vmalloc supported (2022-04-05 08:04:16 +0200)

----------------------------------------------------------------
TEE accept vmalloc()ed buffers for tee_shm_register_kernel_buf()

----------------------------------------------------------------
Phil Chang (1):
      tee: make tee_shm_register_kernel_buf vmalloc supported

 drivers/tee/optee/call.c |  2 +-
 drivers/tee/tee_shm.c    | 35 +++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 11 deletions(-)
