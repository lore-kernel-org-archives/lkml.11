Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A111C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiBVPyW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiBVPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:54:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF782164D04
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645545215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6CVgHNITh5wTbLqWE2e3/qhwXVPmAcMBmmuUl7zJ+g=;
        b=Q+VMkWSNe8gZx1wKSZ0+2HfnyAvGaOjDJNHej8a5iZqXrZUv7SkdwISojMboPujBmS+uvu
        Oeqr1Wctu+ftgXiImpMJEMg4X9C2spQPXxPCcTsS6Lt90UktUSb0pP5qVLd0JXYmwfX0HF
        VeqCfCEBxObyzjVpczgNY51StO41HrE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-hzW2XmveME2mgKz4Yeq6gQ-1; Tue, 22 Feb 2022 10:53:34 -0500
X-MC-Unique: hzW2XmveME2mgKz4Yeq6gQ-1
Received: by mail-wr1-f71.google.com with SMTP id m3-20020adfa3c3000000b001ea95eb48abso997321wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l6CVgHNITh5wTbLqWE2e3/qhwXVPmAcMBmmuUl7zJ+g=;
        b=abN6fNzP1WhBWA8P6FoinMdESBDDsSGGWeRJ6UopXVg0adbXSu7T4TaAhiWNK1q8U3
         /z2lc8HPqHflr7aR2/FnybmNLhkw4MYDwUhLg0z4v91xA63F35JMH2e6MZGiN4qeoDat
         WseAcgpOykYs8hqg59GAgDRKRDH7aA2QGCXrZkMI0fu5PGeQZ/bLZ+YOsQMd9eQnLwog
         RTDy4IJs1640praEu4qx2cmynLxvFkN2iKdvSoieXUhH7xguHNuDg6j9XFQglUWr0UXK
         nJayECwpCSZiIFPZPgmfApjU4Igsz3qWZUHrJ5MJc5l4nDYV6dXW29qKsQOeBKtohZcI
         bjhg==
X-Gm-Message-State: AOAM530Cg+QHPVpZdPXUxbTTH13aYIDhNrEvvOcyFymQf6vkyG6RsDdd
        1dXe3NPZ/4Mi0SwXGnKxn1cez1nfRJMmlcoaddKThkuHkFBoclsRZLJLDGFGZY2OJJkdac9yMgM
        Sicpkp5SIXlFFuDgCPU1Ezj/k
X-Received: by 2002:adf:b34a:0:b0:1ea:8df9:318c with SMTP id k10-20020adfb34a000000b001ea8df9318cmr3083970wrd.190.1645545213445;
        Tue, 22 Feb 2022 07:53:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo3GvDiqubhPSIJifPiUva9RGNbzGHEZatlkRxV1l7JjrHoN2d+MTshFta3P9CUaYL7LMjlw==
X-Received: by 2002:adf:b34a:0:b0:1ea:8df9:318c with SMTP id k10-20020adfb34a000000b001ea8df9318cmr3083945wrd.190.1645545213044;
        Tue, 22 Feb 2022 07:53:33 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c12d100b0037c918292d4sm2532981wmd.28.2022.02.22.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:53:32 -0800 (PST)
Message-ID: <b3d35a3e605880034a619e9a3113980107b6d18d.camel@redhat.com>
Subject: Re: [patch 2/2] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juril@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Tue, 22 Feb 2022 16:53:30 +0100
In-Reply-To: <20220222144907.056089321@redhat.com>
References: <20220222144706.937848439@redhat.com>
         <20220222144907.056089321@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 11:47 -0300, Marcelo Tosatti wrote:
> @@ -918,14 +917,23 @@ atomic_t lru_disable_count = ATOMIC_INIT
>  void lru_cache_disable(void)
>  {
>  	atomic_inc(&lru_disable_count);
> +	synchronize_rcu();
>  #ifdef CONFIG_SMP
>  	/*
> -	 * lru_add_drain_all in the force mode will schedule draining on
> -	 * all online CPUs so any calls of lru_cache_disabled wrapped by
> -	 * local_lock or preemption disabled would be ordered by that.
> -	 * The atomic operation doesn't need to have stronger ordering
> -	 * requirements because that is enforced by the scheduling
> -	 * guarantees.
> +	 * synchronize_rcu() waits for preemption disabled
> +	 * and RCU read side critical sections
> +	 * For the users of lru_disable_count:
> +	 *
> +	 * preempt_disable, local_irq_disable() [bh_lru_lock()]
> +	 * rcu_read_lock			[lru_pvecs CONFIG_PREEMPT_RT]
> +	 * preempt_disable			[lru_pvecs !CONFIG_PREEMPT_RT]
> +	 *
> +	 *
> +	 * so any calls of lru_cache_disabled wrapped by
> +	 * local_lock+rcu_read_lock or preemption disabled would be
> +	 * ordered by that. The atomic operation doesn't need to have
> +	 * stronger ordering requirements because that is enforced
> +	 * by the scheduling guarantees.

"The atomic operation doesn't need to have stronger ordering requirements
because that is enforced by the scheduling guarantees."

This is no longer needed.

Regards,

-- 
Nicolás Sáenz

