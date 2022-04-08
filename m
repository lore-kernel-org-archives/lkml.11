Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A267C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 05:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiDHFMH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 01:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiDHFME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:12:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8825E31E;
        Thu,  7 Apr 2022 22:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=f829VuQmLDhhtfCeHdn2ZYZ3JK
        sPEhknnsSofLiiT2341kU3DBDhNcLEhr7L1UedhWGft7aTpZY40VHuXcAN2acLZETtinIJ6Q8pDXp
        xq+ItMWT2amfZy55wlGouwDpkzM88GcaOZ91n40Hl9ZCLUQYDYGcMvry06l5ChEWvtldfdJDK9Ll6
        f3hKkXFGuOPE7z3LYZYALShDuf/mx7stWXYiIB7eWz7PoXzttgsIhe0QP3rxib7H94DF9cIIASVh7
        cYCFEvjtv0LM8WV9nO4+BimV1bf0WBj9LvXYXnjdBQwa9iL+74+nTQRVOx+aIsrJcmguvk2ao7DZD
        foVkO3TA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgsf-00F1T9-AO; Fri, 08 Apr 2022 05:09:57 +0000
Date:   Thu, 7 Apr 2022 22:09:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v3 1/2] block: add sync_blockdev_range()
Message-ID: <Yk/DpSwR8kGKWJYl@infradead.org>
References: <HK2PR04MB3891FCECADD7AECEEF5DD63081E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR04MB3891FCECADD7AECEEF5DD63081E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
