Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA68C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 15:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiBRPbm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 10:31:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiBRPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:31:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEA12B2FEE;
        Fri, 18 Feb 2022 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GmUv/ttVm2wfuOPqWmkZzcitWBnsr4yfzgC4fzSjBuU=; b=D37nwoFvzptqL/QcnSW6jVQ8Ww
        +/o803MKvjjb6mqmQeYayF4Q/wQOWiIslgrXcyeMtHZRia86/uTirl6OIvF2jwptUZNZ8oILY7JJc
        gmqBZ1aQcwF9a1ZwTEY34rPvfNeIZyWrPLekpZVw+fXbmjOquQ7xh4HxcHYxnKBW5WAu1SLUmJrhG
        Eo0/B/6FpBhUlpjYTCqwP9CMx0jDtQoFAhI0WXDCINUXVKMteMGEL0o59HcU+3OIAYWCLoULL+vZo
        dkWAuRVwiIv7XV70pMxOTioTIbJUz9jMQRp8qsiATuDslE40gt2FVhOUMf4qwpq6XT6l0SwYuzLIQ
        /z19FMFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL5E1-00Gh6j-1M; Fri, 18 Feb 2022 15:31:13 +0000
Date:   Fri, 18 Feb 2022 15:31:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Correct documentation comments for x86
 csum_and_copy_...user()
Message-ID: <Yg+7wV5MD3NZW6S3@casper.infradead.org>
References: <20220205121456.478180-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205121456.478180-1-william.kucharski@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 05:14:56AM -0700, William Kucharski wrote:
> Clean up of calling conventions for csum_and_copy_..._user() did not update
> associated documentation comments to account for the removal of additional
> parameters.
> 
> Fixes: c693cc4676a0 ("saner calling conventions for csum_and_copy_..._user()")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

