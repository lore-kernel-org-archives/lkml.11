Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37019C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 May 2022 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiE1Nxe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 May 2022 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiE1Nxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 09:53:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7370A283;
        Sat, 28 May 2022 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qpQj5MjTNJML+OFknsg22dZadcY9+XhnQrHO9aSW5+0=; b=ZTCcJJF0o5zT1aupPPSo9PI56J
        eiI2prcX18jjDr3Kcu0W7XQfdvpGCiKls6zPH2BEjxsfUSMaNRRwqxYAGZSh4KAiCGmoJzSmqPkBK
        vghBfemqJxYwYtdQtV1okw2mi0axifZU6UL9ADNr+EHMuLaEh0kbSR27o/UiYjjmcVdlBC1QQ2bJx
        guBEY50a0s16Rs4giRar+iynbO27b2jIw6pq5dBCV4Fwtr3GpyQZ4TqgEx0OYdnZ0Waf1laJwqrfC
        yjm/Wmq573LAE3kOdVq6yru/SRLkIP6aun8hcTvU6YtT9MycgfdAdARJXfwwo2KMKE9UBheBIYinn
        /4Kzkavg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuws6-002tyG-1W; Sat, 28 May 2022 13:52:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A376E980DC1; Sat, 28 May 2022 15:52:47 +0200 (CEST)
Date:   Sat, 28 May 2022 15:52:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, virtualization@lists.linux-foundation.org,
        pv-drivers@vmware.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3] x86/vmware: use unsigned integer for shifting
Message-ID: <YpIpL728ii08D9uK@worktop.programming.kicks-ass.net>
References: <20220527175737.915284-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527175737.915284-1-sshedi@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:27:37PM +0530, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <sshedi@vmware.com>
> 
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.

The kernel builds with -fno-strict-overflow and as such this behaviour
is well defined.

> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")

Nothing broken, therefore nothing fixed.
