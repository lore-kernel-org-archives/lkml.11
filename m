Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE90C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 06:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiCIGQq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 01:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCIGQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:16:42 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C4154721
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:15:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9454468AFE; Wed,  9 Mar 2022 07:15:41 +0100 (CET)
Date:   Wed, 9 Mar 2022 07:15:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220309061541.GB31316@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309053711.2561-1-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote:
> +		if (port->nport->tcp_congestion) {
> +			icsk_new = inet_csk(newsock->sk);
> +			if (icsk_new->icsk_ca_ops != icsk->icsk_ca_ops) {
> +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> +					icsk->icsk_ca_ops->name,
> +					icsk_new->icsk_ca_ops->name);
> +			}
> +		}

What is the point of having this code?

> +	if (nport->tcp_congestion) {
> +		strncpy(ca_name, nport->tcp_congestion, TCP_CA_NAME_MAX-1);
> +		optval = KERNEL_SOCKPTR(ca_name);
> +		ret = sock_common_setsockopt(port->sock, IPPROTO_TCP,
> +					     TCP_CONGESTION, optval,
> +					     strlen(ca_name));
> +		if (ret) {
> +			pr_err("failed to set port socket's congestion to %s: %d\n",
> +			       ca_name, ret);
> +			goto err_sock;
> +		}
> +	}

Same comment as for the host side.
