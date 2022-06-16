Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32341C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 06:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358977AbiFPGMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350136AbiFPGMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:12:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487C29824
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dapB6H6eFYmTc+OyGbQwY3SFwU4g6u4noQOzoQl1YU0=; b=M5fVvBHC429l5XNlp98Z7FDXFG
        tbmyU7kv9W6Z47SRggvA9ARSKHXS7uKnYLxpeNnvYx59PCkpBeOetmiTG42BVPuY5ODUJO9uIB/tQ
        PsdwBIJpiy4nZpJbDP4uy+3t3CJiju4Eb+mz5oaxu1hJiP8xhOBFAG+kxf6zxfM4eips9j73jP0Tc
        mJKSVYEcWwOcdWDdi8bYuHafFwXEx427S3ce7TOdd20ups9kPrTFC1cHRBx/oMUqyM9ihtg3b4rfm
        KS+wekOBZKunfjJTr4rZwNNshpsvXN7kKlbU2sBOAvv/it3kYbswxU9OQ+WAXWVc/jhLSWhB6/dvm
        U1GH+gXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1ijl-000gwA-4u; Thu, 16 Jun 2022 06:12:13 +0000
Date:   Wed, 15 Jun 2022 23:12:13 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Message-ID: <YqrJvV/dWK/iyVvR@infradead.org>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
 <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:45:39AM +0000, Christophe Leroy wrote:
> > +/* Note due to the way vm flags are laid out, the bits are XWR */
> > +pgprot_t protection_map[16] = {
> 
> Was const previously, now back to non const ? Maybe due to a conflict 
> with linux/mm.h ? At least it should be __ro_after_init.

Maybe we just need to duplicate vm_get_page_prot in all the
architectures and thus avoid making protection_map global in a
common header entirely.  That certainly seems like the cleaner
interface.
