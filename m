Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A6C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 05:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiGYFhP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 01:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 01:37:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1BCE02;
        Sun, 24 Jul 2022 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=X3C9PMm7pBOdADGL6OXRK2QP3l
        h8JwXR7pJaU4JKge5s4LXQCXYREi0ch/PpcGRc/PU4+ryfmSwUDZEfRPD0SosQrDgVoAHHmjG79xy
        p2VLOX2siCZDHxLo8hfcUSMPFDxKmwaPJHodGVLYG5g1P5WNh7AJtdyFccORXUJ/nQP1L9yZs0t+h
        /pa4LLicJ1IGd5xgTaTWuulVM+vf8Zj+liFvnfhdcfxofrR0b4CN8H0OONzKWNYsV/SuUDDzHDwcr
        pnmDKi6L0lefdCO1XpOhm05f/zs5P49Ir6iCPpmVAUFa2NHzaULB7LneOoSU+ucsvRXrmDGHomSiI
        ZRXRs4+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oFqmD-004ZHj-G9; Mon, 25 Jul 2022 05:37:09 +0000
Date:   Sun, 24 Jul 2022 22:37:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-auth: Fix off by one checks
Message-ID: <Yt4sBQgW0fFwo9Um@infradead.org>
References: <YtU/bFMYRCrx6tgp@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtU/bFMYRCrx6tgp@kili>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.20.
