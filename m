Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 11:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiBRL23 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 06:28:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiBRL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:28:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144013F893
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:28:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v4so8320136pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PK/ubS/6VsrQfiT6fGu4snd5NM7nEqZO9rUfJO/NsiI=;
        b=n/cvs6OXRCT6uPZ/Yw7GOroXVfh58ytcqRxwlJXMudjxgtROBVythTC/elOjbwNC3u
         UH9nSTNV9ahF0MqrDCfr+DfIi8+vD4xNJ4qdK5ApItATZ0grW1xWnHAenvlSJ7NIIoj3
         0FK3cM95L6B3YdgR8Dp2MOJHgdED9iU6z2vgxjXLJxciDepCwVki4Kb96IOBfojKypXA
         AENFOrP9JnnwZ5pKQThwrwWgTut7f8LDlWtNTk4+Jk8ffzjg8/EXw7SI7nzgXFNsAFaT
         2FGQy82gtk3SROxpDsW0cDqTFGSozWPPDbNulKfLODuimfsD6DkJA3THtl2LYxKeKM1b
         T43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PK/ubS/6VsrQfiT6fGu4snd5NM7nEqZO9rUfJO/NsiI=;
        b=BvKrLJB6ZyHC89btdBpjI42RlEu9rt2QTi5vDzfflF9WMrnITuMTxG1O90/0de3C3J
         T5hZAIHBmAHSIRMuE2y0DV3z2W/LISncgQElZ2wvxSK6cE+hRyWjmhDJoS8nPD9F1vCc
         hOj5xE90WOD+NlKaMgzvRzP+0MuuGj/J09ybAy4eIO4Aw9B18Kqor/wQWsrIORu+fa4G
         kOyL+yXSn7P7hSaTx2gJH07D0XpH0Jpn65eET4gicznxRm9wSwDQbTIKdlZDJhT6SARE
         ZFClmqHYqC/asYgp12FOFG8w0iN6GN1zIRNuPDSYAC7l6qlvkSpi3oJpX5xKdAi1DtO5
         agRw==
X-Gm-Message-State: AOAM531SlNGnKRPAkbZnSlsseX02Xoq5O23dW61f8QgS33mZ1MAD+HPu
        Gm7EHGJYAArfoGCnDyAlkTM=
X-Google-Smtp-Source: ABdhPJy3Gih8h6AYa+elDZwsK5cx+J5xZ+6EWCZm6XLpJpwnVTm7xeYAKheh5zAXCfPVi6sQ7lPfKw==
X-Received: by 2002:a17:903:143:b0:14d:44e7:5886 with SMTP id r3-20020a170903014300b0014d44e75886mr7051510plc.148.1645183689452;
        Fri, 18 Feb 2022 03:28:09 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id ob12sm5222899pjb.5.2022.02.18.03.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 03:28:09 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <song.bao.hua@hisilicon.com>
To:     shankerd@codeaurora.org, will@kernel.org
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        scampbel@codeaurora.org, tglx@linutronix.de,
        tspeier@codeaurora.org, vikrams@codeaurora.org
Subject: Re: [PATCH] irqchip/gic-v3: Use wmb() instead of smb_wmb() in gic_raise_softirq()
Date:   Fri, 18 Feb 2022 19:27:52 +0800
Message-Id: <20220218112752.9811-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
References: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	 * Ensure that stores to Normal memory are visible to the
>  	 * other CPUs before issuing the IPI.
>  	 */
> -	smp_wmb();
> +	wmb();

Sorry for waking up the old thread. isn't dsb(ishst) enough here as we only
need to guarantee the visibility of data to other CPUs in smp inner domain
before we send the ipi?

> 
>  	for_each_cpu(cpu, mask) {
>  		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));

Thanks
Barry

