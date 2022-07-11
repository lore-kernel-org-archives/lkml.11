Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C63C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiGKPBy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiGKPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:01:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD134747B0;
        Mon, 11 Jul 2022 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1kgE/Y6l01V6Wz1Edn/qbPsgnQsJgXCJQEDblFsTCVY=; b=AXL7o6/UZ6PDCaTIGgY7zzdx7t
        OkFNTHSsziCYPum+F0RkL/CD4h1q4U4dv2I3aJVszyapx5YKXQGx9DnI4Y38kEbatWmdglLEb7VTQ
        4e17N0RGD0sybI7rIRB5wzyYm0VjwjA7RRp2z+Wmzo1xoNuEX90MwaPC40BAx/cwCjzb/yqn1cWD1
        nWZwMzguNHUYEhvjop042jwsBtlsvyUwNZpYHmcEiL9+rZMk+OnucQCL9RpTj+XdnOAXq7Sk7Rkin
        /EfM0UvcSRSh5i8DRln5D1WXv3ANYAOoSSM8ifSA/goKIYg76xw3U7z0hChwFR3aYQYPiMWyVfskC
        UW2TSAKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAuui-002hCr-9j; Mon, 11 Jul 2022 15:01:32 +0000
Date:   Mon, 11 Jul 2022 08:01:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Chen <me@linux.beauty>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] add struct page and Direct I/O support to reserved
 memory
Message-ID: <Ysw7TMFO8Mw0nq8x@infradead.org>
References: <20220711122459.13773-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711122459.13773-1-me@linux.beauty>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Who is going to use it and how?  Because normally the reserved memory
is used through the DMA allocator, and you can't just do direct I/O
to that.
