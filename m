Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9FAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 12:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiBXMDc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 07:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiBXMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:03:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B820D82C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RcyygvmcLReoBtZ0CkCckdYWq6gYr8Kblc5/vEzgApQ=; b=NvwVIqSR7fbffKXE0p5j5bXrIY
        220Rmqe1SXE4/53c0iqbuyM42OpHIHqGRID3i4u71JO0IsHga7Ppx76xMuJ8ITMNUk5VdwQdX3LGX
        ELrObJqdG826VDVrdup6XM+VftCps1oLv5KArMLo6N3dklm0+nDtTDlXe4Zi4kmpIJ29vWt4S2gc7
        qnj4utnMlqz5dw73lsxYkQKnrksluCO2kKeVQD3vm7nbg3PR6nzPcF9RWmBwk//UOnxO7iBmQHCqZ
        wQNIpJAWjcrVZGXSnZBHbFRULmXhfhMtAk1xQYR12wxkO6pKAeSDeVOhhFYK3k/3gKaqvh5uFcZt2
        NZ1jpj+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNCpU-00Cbrl-0j; Thu, 24 Feb 2022 12:02:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6124300230;
        Thu, 24 Feb 2022 13:02:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CBDB201C20B8; Thu, 24 Feb 2022 13:02:37 +0100 (CET)
Date:   Thu, 24 Feb 2022 13:02:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Junru Shen <hhusjrsjr@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Put the fetching of the old value into the loop
 when doing atomic CAS
Message-ID: <Yhdz3W3cnKtVmBYc@hirez.programming.kicks-ass.net>
References: <20220224082438.580191-1-hhusjrsjr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224082438.580191-1-hhusjrsjr@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:24:38PM +0800, Junru Shen wrote:
> Put the acquisition of the expected value inside the loop to prevent an infinite loop when it does not match.

NAK, this is broken.
