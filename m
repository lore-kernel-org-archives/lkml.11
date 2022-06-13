Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84654C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 19:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbiFMTdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241338AbiFMTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:32:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807B61293
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:57:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C78768AA6; Mon, 13 Jun 2022 19:57:25 +0200 (CEST)
Date:   Mon, 13 Jun 2022 19:57:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ning Wang <ningwang35@outlook.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI
 TiPro7000 SSDs
Message-ID: <20220613175725.GA15847@lst.de>
References: <SG2PR06MB33380A046A4E047A37B1153CCBA39@SG2PR06MB3338.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB33380A046A4E047A37B1153CCBA39@SG2PR06MB3338.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.19.
