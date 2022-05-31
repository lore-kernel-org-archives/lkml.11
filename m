Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71993C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 05:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbiEaFmq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 01:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiEaFmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:42:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8595A08;
        Mon, 30 May 2022 22:42:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA2D768AFE; Tue, 31 May 2022 07:42:27 +0200 (CEST)
Date:   Tue, 31 May 2022 07:42:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Christoph Hellwig <hch@lst.de>, kernel-janitors@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix typo in comment
Message-ID: <20220531054227.GA20486@lst.de>
References: <20220521111145.81697-26-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-26-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.19.
