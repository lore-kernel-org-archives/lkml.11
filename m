Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42516C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 16:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiCDQV0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 11:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbiCDQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:21:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084851C2314
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:20:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 836D168AFE; Fri,  4 Mar 2022 17:20:32 +0100 (CET)
Date:   Fri, 4 Mar 2022 17:20:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220304162032.GA12250@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com> <20220304092754.2721-3-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304092754.2721-3-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll let the NVMe/TCP maintainer comment on the actual functionality,
but:

> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			key = tcp_ca_get_key_by_name(NULL, p, &ecn_ca);
> +			if (key == TCP_CA_UNSPEC) {
> +				pr_err("congestion control %s not found.\n",
> +				       p);
> +				ret = -EINVAL;
> +				kfree(p);
> +				goto out;
> +			}

We can't just call networking code from nvme-fabrics.ko
