Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A121BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 06:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiFXGaN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXGaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:30:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC810522D2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eM3nPBUw4PZqEb4da6i4+WfgBSGu0ZhJXRXjJDXCY9o=; b=i9qQhcdkZ9YRwP2xlPKLAlC1kE
        U5oCUS92EsXe4sMJC27RUPI4Jb2Sa1N/9Lny1UbMxaPjFJcwVtohB4yKHOzzN2iVAQZ/uq62Atrq6
        Sk1g9vIZ85uAzLvLlCM7x0W4p6r6AGnUbDBY1EoQ0CoIa1qjZATHx/6PvmNeYDF7oYYYEPMJdurML
        c+unsTDU5AmsUN+FD+NAt4iUFES+NPq27r20RJKcJMKiqRh3rbWg3Ra32s6m32ADTbywqxezpkIhT
        nJ0kDrIUxZKTCEVl8lCQAU9ckiK/HS1FzgOKCjwDjxbiWhZOzAFbf3X7tI2u5+wC5QGUP/XxTplYS
        Nxc6Zz0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4cpS-000qZQ-C0; Fri, 24 Jun 2022 06:30:06 +0000
Date:   Thu, 23 Jun 2022 23:30:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] MAINTAINERS: Add new IOMMU development mailing list
Message-ID: <YrVZ7g3AKzoI0uMG@infradead.org>
References: <20220622082601.31678-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622082601.31678-1-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:26:01AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The IOMMU mailing list will move from lists.linux-foundation.org to
> lists.linux.dev. The hard switch of the archive will happen on July
> 5th, but add the new list now already so that people start using the
> list when sending patches.

iommu@lists.linux-foundation.org is also listed for various other
MAINTAINERS entries.  Can you please send a list to update all of them
to Linus ASAP, including for 5.19 and -stable?

