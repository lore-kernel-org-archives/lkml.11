Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833DFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 19:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiGNTe6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiGNTey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:34:54 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16B2BB3B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FRi6FX1mHfIDY8XJziHRe5A/6ngtGKMangsD1+ldoWY=; b=grq8cX6NN7Zndo+VE4Cg6W7oRd
        w1+eQbW+a/UX7G+VLEXLvx3Zo3qFAvjLt8eWNkuPlbuH1Lb11BNNJfVvRz8C9gaYVEIrwR3sI4dFO
        eM3GjT7ojx7wiQEBP4K5FMJWdlwA9yWeyuy78p6z0PqRbV2PKZMLet0ki/C31YBA1Kg9UBLCBOolp
        P+LmPzx4Ouv6RL/TioGnrb4P4zMWQcJf4vV7aAqg8nDmylbBnsV2CZpAJUFqD/HFntpzvCk27rSRk
        bhotmfsGYHTdd2JIOFdCBFR0olLgfhgj0a8j82ZtkGCte/I1DsA6OnBuSaaGWpNieRLxF1BHTEkbX
        3ghR/quw==;
Received: from 201-42-109-188.dsl.telesp.net.br ([201.42.109.188] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oC4bk-00GmV3-G3; Thu, 14 Jul 2022 21:34:44 +0200
Message-ID: <bf57256f-127d-6f26-404a-b9cff6df70b3@igalia.com>
Date:   Thu, 14 Jul 2022 16:34:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Unstable tsc caused soft lockup in kdump kernel
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org
References: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YrwokiIVX9E9kQIh@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 07:25, Baoquan He wrote:
> Hi,
> 
> On a HP machine, after crash triggered via sysrq-c, kdump kernel will
> boot and get soft lockup as below. And this can be always reproduced.
> 
> From log, it seems that unreliable tsc was marked as unstable in
> clocksource_watchdog, then worker sched_clock_work was scheduled. And
> this tsc unstable marking always happened after sysrq-c is triggered.
> And the cpu where worker smp_call_function_many_cond is running won't
> be stopped and hang there and keep locks, even though the cpu should be
> stopped. While kdump kernel is running in a different cpu and boot, then
> soft lockup happened because other workers or the relevant threads are
> waiting for locks taken by the hang sched_clock_work worker.
> 
> Any idea or suggestion?
> 
> The normal kernel boot log and kdump kernel log, kernel config, are all
> attached, please check.
> 

Hi Baoquan, interesting issue! Do you happen to have a full kdump boot
log with the issue? Maybe collected through serial console, etc.
It seems the one attached is from a succeeding kdump by passing
"tsc=unstable" to the kdump kernel right?

Also, did you try to "forbid" tsc to get marked as unstable in the first
kernel, before kdump? I mean like a hack code change, just prevent
kernel doing that and seeing if it works. If that still fails, then it
seems the cause of the issue is the same as the cause of TSC getting
unstable - in other words, something would be causing both the kdump
kernel lockup AND the TSC unstable marking in the first kernel...

Cheers!
