Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA083C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 10:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbiBYKXr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiBYKXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:23:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7852119D778
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Cpt1E+7OEdYKYdmKS/UXp7CWpeURIQVfRcxn4+eolw=; b=UgBDHa0cu00NwxAnGGhbsYwT+j
        31BtNjVhPgvnCuKQMbdnLe03ang4PJnPYhlApnEVefR1cvbojqsr2cNFgM6oa2O6mrVYBrA60GmRA
        V9ZetdBwPNZ6FbsfERU23BndGvsybsUUGiIQSHt8xqCIyVEeU9d5tLaY2j0ed9BFlRuV0i0PJKasI
        gUUG+RMfkkJpxkeOESutbRID1ilsqvjDgGllKFZ9oI0FlxckjPdnK2VRlzbMd+9Hxmg1wAyTjwfPi
        /LR7bS7IzZKgluNxneI+Ho8ut1+na3BKp+Xc5QBMCo5+nzo9YDFZSSC1R1V1ERi/omFT/gZShNxTh
        0aKktPJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNXkO-005gq8-PS; Fri, 25 Feb 2022 10:22:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E330300230;
        Fri, 25 Feb 2022 11:22:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A23C2D66F32D; Fri, 25 Feb 2022 11:22:46 +0100 (CET)
Date:   Fri, 25 Feb 2022 11:22:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 10/39] x86/ibt,crypto: Add ENDBR for the jump-table
 entries
Message-ID: <Yhit9iXttJ5NJRxo@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.598835921@infradead.org>
 <202202241648.C349B75@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202241648.C349B75@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:50:40PM -0800, Kees Cook wrote:
> On Thu, Feb 24, 2022 at 03:51:48PM +0100, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Can you put some details in the commit log here about why these are
> needed? My eyes can't find the indirect users...

	## branch into array
	mov	jump_table(,%rax,8), %bufp
	JMP_NOSPEC bufp

:-)
