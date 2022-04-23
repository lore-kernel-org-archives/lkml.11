Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28600C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 05:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiDWFYB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 01:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiDWFX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:23:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A969CF0;
        Fri, 22 Apr 2022 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1Pd0EN3sl1N8+yOIX9ZvqsKxN/
        mLyovwdLfqA8Ua0rnflF4QFeCkpAhAFTFtTPP8y6Een5eQUgbVBnGSb9O9LcsY5mp8Y/eossw1iVJ
        n//G2gxdoKibnpQot99FOYMA+3gssXrNlbjyNben3j5U15364xRr43gwxx1xaLjE1eLBalkOsO1W1
        VeENhlptLVaNSEUhhBFUThN7kCm0zeog2sPLIl3qDU+XvnduLpanMNcetTRYnvVlOPjZC6jZyJfzv
        1nIgvRo3vtdmoHXjVQDMVA+7eVt6Nwy95WfaY27l+PzQ9p+FlJqbLI7JwGRizoOlepcS7+JF2UhQ7
        HjTE/09A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ni8CP-003TJ8-92; Sat, 23 Apr 2022 05:20:49 +0000
Date:   Fri, 22 Apr 2022 22:20:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: Re: [PATCH v9 4/7] dax: introduce DAX_RECOVERY_WRITE dax access mode
Message-ID: <YmOMsTyGhD73koYH@infradead.org>
References: <20220422224508.440670-1-jane.chu@oracle.com>
 <20220422224508.440670-5-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422224508.440670-5-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
