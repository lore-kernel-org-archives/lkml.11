Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 09:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiERJDW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiERJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:03:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC1134E2B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=feM3pQlldI2orQ7XOsuamYkeeXGQMyYBNuTPV9AR2Cg=; b=GSi+57VMWVhEdVyeYEjBmKvYWn
        nC6eZ5J/bQRxlCMiIYiIhSifxz0TLyHFSbc1+golGU099FvOC8kGfKywY77rP6Rh/CDFytx9XNugL
        N8nh6d/C2LdT8sl6MiDTk0wi4OnflkIoLV4J5BH2FTWGEhJ9gjssfS8UuG8QsLGL81eHpIPBb9v62
        kkQ31zVcnW73Qnz2L1NfgG4T+N8iAlbFjw2FTr+EqSZqQ32Bs+Fj3DFhjy3R4lg0vOl8f+QejXHTy
        ww4LPCZrDMfWuTzKoQ5I9IrHGOF7+igEed0cpI8PyLpdbwVX3hpyEjKntx46f/2EBLWvUxP0MN5pW
        zzjzS/Hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrFa2-000ixL-9R; Wed, 18 May 2022 09:02:54 +0000
Date:   Wed, 18 May 2022 02:02:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com,
        donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] smp: consolidate the structure definitions to
 smp.h
Message-ID: <YoS2Pr0StLIrueCE@infradead.org>
References: <20220517180326.997129-1-dqiao@redhat.com>
 <20220517180326.997129-2-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517180326.997129-2-dqiao@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This still makes things that were private public for no good reason.
