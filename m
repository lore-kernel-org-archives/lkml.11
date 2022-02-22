Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A56C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 17:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiBVRb1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiBVRbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:31:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDEA170D4D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:31:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4724568AFE; Tue, 22 Feb 2022 18:30:57 +0100 (CET)
Date:   Tue, 22 Feb 2022 18:30:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, qiulaibin@huawei.com
Subject: Re: [PATCH -next] configfs: fix a race in
 configfs_{,un}register_subsystem()
Message-ID: <20220222173057.GA15331@lst.de>
References: <20220215071030.3067982-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215071030.3067982-1-chenxiaosong2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied.
