Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBA3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 06:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385498AbiDUHAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380886AbiDUHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:00:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD41583F;
        Wed, 20 Apr 2022 23:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DxYVFPqhw7EnfsZEYTXHcUR3ApSQdJ6o31Q8vRA3VKw=; b=SfuV6EQAHeinwPkf3hcym0/Xob
        SQ1klssE18KyBbQZ5Nh/e95MAq1KO/mLU7YLXQX8BGIDq/YyAeM8YClulitOVYqttaAkORvVmLsDZ
        0SJzoBoUYgIYUVU+Dmh0XlO0T+blI+Zk7evK9t6fMpt03MzZwzCJ95njWKqHPmdEi1UEiMeuNNX8m
        ec3u1DQJZ+FqkjMMu/1Pr143NQW46bCDQu7RuOHjxi0kIiuPctNXC1f4CL3p0NIdzc2fQMIPoTgcW
        BIpm9oJl7+WOqQi6ydsJZYpB8wPDwhqRIlcSpxxW+bDog9j93yNtOjVU6vtR7P0cJsfW/Y41vZ58i
        U+LYdR+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQkd-00BuPJ-S6; Thu, 21 Apr 2022 06:57:15 +0000
Date:   Wed, 20 Apr 2022 23:57:15 -0700
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
Subject: Re: [PATCH v8 4/7] dax: introduce DAX_RECOVERY_WRITE dax access mode
Message-ID: <YmEAS5hi7Os9Lgcq@infradead.org>
References: <20220420020435.90326-1-jane.chu@oracle.com>
 <20220420020435.90326-5-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420020435.90326-5-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (bb->count &&
> +		badblocks_check(bb, sector, num, &first_bad, &num_bad)) {

Weird alignment here, continuing lines for conditionals are aligned
either after the opening brace:

	if (bb->count &&
	    badblocks_check(bb, sector, num, &first_bad, &num_bad)) {

or with double tabs.  I tend to prefer the version I posted above.

The being said, shouldn't this change even be in this patch and not just
added once we add actual recovery support?
