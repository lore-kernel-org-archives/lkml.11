Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964DFECAAD5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 07:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiH2H3q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH2H3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:29:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764CE4DF3C;
        Mon, 29 Aug 2022 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MNVGNrLym90eTR2Hwz3e1+md5hxLSYVBzY21I+sVSlw=; b=URsm2wtKYYHmS08ytu4Qd30NPD
        ODWVFQuL3lb21s+MLMy49hPNR6+yCimxybmksJGzUnOXPeDOws0pUCpmlOUhH+LJtkyKL9RozGhQv
        9TO++P6LBllE8xXI9oKukAsHV2GS+lhZuY8x7oWB5A2QtoMDLNOdCPjBmxkFh0Ws6mXgFsi0RlvrC
        sj4n3Daz/waXBka3HHW1m1uoojT/IZSolO5VOleK4MAV/V1KrsValX6jW4JR/bMh6gF0LVWygeQQk
        9vrNCrYhpk+CqTGcx4pfR66TmYy0bnfESKdzyoxSYcVROVG4ki0CeIbsZedJGIcF4UH8uRYhnrR1+
        DJ8qwH9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSZCu-002u2X-NM; Mon, 29 Aug 2022 07:29:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E6E23002C7;
        Mon, 29 Aug 2022 09:29:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 320612016BB08; Mon, 29 Aug 2022 09:29:13 +0200 (CEST)
Date:   Mon, 29 Aug 2022 09:29:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <YwxqyZ5vyLX1mxZT@hirez.programming.kicks-ass.net>
References: <20220829085730.142da032@canb.auug.org.au>
 <f6919bbc-e332-8d93-dffa-0cbe70463542@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6919bbc-e332-8d93-dffa-0cbe70463542@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:24:15AM +0530, Anshuman Khandual wrote:
> Hi Stephen,
> 
> The original posted patch had author's 'Signed-off-by'. Seems like the tip
> extraction have cut out portions of the commit message as well, apart from
> just dropping the "Signed-off-by" :) We should keep the commit message in
> the original form. Could you please fix that ?
> 
> Original patch: https://lore.kernel.org/lkml/20220824044822.70230-2-anshuman.khandual@arm.com/
> Tip extraction: https://lore.kernel.org/lkml/166155215090.401.870330359879147742.tip-bot2@tip-bot2/
> 

Urgn, that's my script triggering on your ------ lines. Let me see if I
can rebase that.
