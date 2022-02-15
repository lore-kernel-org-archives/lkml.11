Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43013C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 00:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiBOAIZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 19:08:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiBOAIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:08:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CB97B9A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fmjiWp0AfBWkfmPntOo81MCM/Quqim7sKRumuLpgEzg=; b=V1VOGF0sO+TyYWYk89Da5MbJrx
        4Q+sXuzLuW3McxurFEvjt1xoM0pjAKo5CZkEvH4b21HvFgfi6Qbtb/1svyc+5O09COtuJb/Tey0oi
        rcsVmT1fbTw2S4FDrwDG1KdPjHmxw4a/6YKMqeKrBnCt4vJ5nwxKuv1QyFBSm1c0HkwB+z7BpUBDX
        VOhe5Yz2CrnkFM/78Jxw7sp2Q/rXD07B+gq7wGPatT0ek7reUofDaV2OQE41p2eql/sQJKR/AfDUW
        jmPWuy9N16SNG6/5vSR5l8fHXp/4QCTcZtkmQIPc7o4dAJQwTLl2h6Nf6vy5GPsxM64dMN+rbuFrh
        F2BMXnYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJlO3-00DMe5-7c; Tue, 15 Feb 2022 00:08:07 +0000
Date:   Tue, 15 Feb 2022 00:08:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [willy-pagecache:fs-folio 44/58] fs/hostfs/hostfs_kern.c:507:17:
 error: 'filemap_dirty_folio' undeclared here (not in a function); did you
 mean 'filemap_get_folio'?
Message-ID: <Ygru55cGa9/dQ23R@casper.infradead.org>
References: <202202150745.y8wccCv3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202150745.y8wccCv3-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 07:58:24AM +0800, kernel test robot wrote:
> commit: 117ba9cd89727cdc7262cb6088ea070ae1ef2a98 [44/58] fs: Convert trivial uses of __set_page_dirty_nobuffers to filemap_dirty_folio
> 
> >> fs/hostfs/hostfs_kern.c:507:17: error: 'filemap_dirty_folio' undeclared here (not in a function); did you mean 'filemap_get_folio'?
>      507 |  .dirty_folio = filemap_dirty_folio,
>          |                 ^~~~~~~~~~~~~~~~~~~
>          |                 filemap_get_folio

Thanks, fixed, update pushed.
