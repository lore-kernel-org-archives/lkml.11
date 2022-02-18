Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A19C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 17:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbiBRRTB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:19:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiBRRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:18:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5275F4F1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FPao8ve7CqUFIuLbc6WroIn7poc51TKJEXVHXjV9YSg=; b=0vk3fawBxAA3Zyo+HOySJO16xm
        QM0smNNswcQtLG+o9GG7dHmaVtSnYVHSfUz5Mge5dYFIBlkluzLJxPRhAFuT/tTWwUxw+O27q2jA8
        Iea6UNTH5MPnAQhl5IByFF1vcZ7mWr8dJg3IEbXOy7B+3lvvhxI7XSXJddBoeYwVXNdnRmNg8z6zA
        48Gl71TFU1qhUQCUiVE5OTJ0Rr4YQud6B06ovvd3jy1p/k3UDlGRNYVtqgWHpEAurTd2Nj2OqulVo
        m+CUoZTAZIlYdIOUVRhc5X2dDDhkTi+wdY74Cr8zqlIfA2Rj56O3dh48marJ9LVKWLNAud/CYlXW9
        oJiOyA4Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6tU-00FNCv-5f; Fri, 18 Feb 2022 17:18:08 +0000
Date:   Fri, 18 Feb 2022 09:18:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     yzaikin@google.com, keescook@chromium.org,
        zhanglianjie@uniontech.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] mm: move page-writeback sysctls to their own file
Message-ID: <Yg/U0Lfn4w7prn86@bombadil.infradead.org>
References: <20220218025152.1B4C7C340E8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218025152.1B4C7C340E8@smtp.kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:51:51PM -0800, Andrew Morton wrote:
> From: zhanglianjie <zhanglianjie@uniontech.com>
> Subject: mm: move page-writeback sysctls to their own file
> 
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we just
> care about the core logic.
> 
> So move the page-writeback sysctls to its own file.
> 
> [akpm@linux-foundation.org: coding-style cleanups]
> akpm@linux-foundation.org: fix CONFIG_SYSCTL=n warnings]
> Link: https://lkml.kernel.org/r/20220129012955.26594-1-zhanglianjie@uniontech.com
> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Queued on sysctl-next.

  Luis
