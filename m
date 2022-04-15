Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E86C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 06:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbiDOGt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350823AbiDOGtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:49:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E7CB18A0;
        Thu, 14 Apr 2022 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a15IgzCBGiGWJfnLVtPP4LMnUkGHMDur6ILlVeSBkm4=; b=sdup4SptYer8etuY8zgqpPEfcY
        2wntqId5LyhW+g4ZpPEq9D1NXaBHbczKAvhXIVi6qny3bJ9mRkLYjJ4cj8JuFHi+XFuFAWPCzUsgt
        TUpTUMgU92EPp5/576dw+GYIiAEv21tLLV5BSFKkOnrNhixb+h2Ggvs68E6A8a4ueX0ZPsG+tKTlk
        IFQiUvJEGE556iWK7CKkgRLIpMryA/bI/RwxUGqTOtARmFqRPYCNUfiQ/muApdZ0++MU/EpMidMwz
        PQl56t7IrVLtAd60EK9vrH1OBAnu7Qd8uu8w3ff6o08amsV+PK8HT9eLqJRmChsVwepFuIYeNumA9
        SOpqjcEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfFje-0096Oz-19; Fri, 15 Apr 2022 06:47:14 +0000
Date:   Thu, 14 Apr 2022 23:47:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yao Hongbo <yaohongbo@linux.alibaba.com>, mst@redhat.com,
        alikernel-developer@linux.alibaba.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uio/uio_pci_generic: Introduce refcnt on open/release
Message-ID: <YlkU8pLLlbo4WgQC@infradead.org>
References: <1649833302-27299-1-git-send-email-yaohongbo@linux.alibaba.com>
 <YlZ8vZ9RX5i7mWNk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlZ8vZ9RX5i7mWNk@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:33:17AM +0200, Greg KH wrote:
> On Wed, Apr 13, 2022 at 03:01:42PM +0800, Yao Hongbo wrote:
> > If two userspace programs both open the PCI UIO fd, when one
> > of the program exits uncleanly, the other will cause IO hang
> > due to bus-mastering disabled.
> > 
> > It's a common usage for spdk/dpdk to use UIO. So, introduce refcnt
> > to avoid such problems.
> 
> Why do you have multiple userspace programs opening the same device?
> Shouldn't they coordinate?

Independent of that (very valid) question I think the current code is
just broken.  Either we need to prohbit multiple opens or do this kind
of refcounting.
