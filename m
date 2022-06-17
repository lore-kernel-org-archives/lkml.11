Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E952DC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 08:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380101AbiFQIA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 04:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380812AbiFQIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:00:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E1D68301
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yf7G106I8eNg8huKyNP39rS31x9Ej2FmZ3Uo3WWeHGY=; b=LzkqBO94I0vxhnWzupo1KJ0EqG
        ImLWffGADwMU25oDy7TVOtrslVbzZqZOIFo/tGhcbCPX+IiT/j1k1ssPumpyZuOpbTHN4byOIo+5O
        2BQQbjKqxIuSr5f001yH79PSynVj85NM76xKhiTOGZx8v+cB/ttPTPo3YcWjjDY/b/9oMxziP4oht
        4i7QnhoLFGRBDYrnGSD2XZtzVus5/RBMDfSKp4PZjQePqaDzLR6qMLtyDpZbsPM1Jkda0kG/alAMr
        49HqJ7ZFchRB3BjXrpvVLIamk0gADkXi5gcYdGKe1TC4gD5kT6C11GHO28HVeyU1Nko5I0gFDzAZo
        a3H15vVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o26uF-006BZP-Ar; Fri, 17 Jun 2022 08:00:39 +0000
Date:   Fri, 17 Jun 2022 01:00:39 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Message-ID: <Yqw0pxSNLZWPyPIG@infradead.org>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
 <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
 <YqrJvV/dWK/iyVvR@infradead.org>
 <7c72a97f-d7d4-db27-faa5-fec01673cca7@arm.com>
 <43205917-0517-4e45-6fbf-4fc849fb0325@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43205917-0517-4e45-6fbf-4fc849fb0325@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 05:48:11AM +0000, Christophe Leroy wrote:
> Is it a good idea to duplicate vm_get_page_prot() in each architecture ? 

It is a completely trivial array index.  And I really like the idea
of not having the protection_map in common code - it really is an
implementation detail.  But what we could do is something like

#define DECLARE_VM_GET_PAGE_PROT				\
pgprot_t vm_get_page_prot(unsigned long vm_flags)		\
{								\
        return protection_map[vm_flags &			\
		(VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)];	\
}								\
EXPORT_SYMBOL(vm_get_page_prot);

as a helper for the architectures.

> Maybe it is, but it will also mean changing common code like 
> mm/debug_vm_pgtable.c which accesses protection_map[] directly as of today.

That's already gone thanks to the good work from Anshuman.
