Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5EC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 04:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbiEaEXn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 00:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiEaEXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63AC50049;
        Mon, 30 May 2022 21:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F9B61159;
        Tue, 31 May 2022 04:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEF5C385A9;
        Tue, 31 May 2022 04:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653971019;
        bh=4zB8kFUtyy239Mg9l83Bmm6qEvBIdT1YvQ7BPbiKo6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HpmrVF0tw3RIGGt/npXSo0UR6siEKrvqlGkd8MSMUlhjg8FMF75j/chQaRHPQznIf
         J/Ys1+9QCN9txqlpLfQs2nps9HjTZCzIHh931bN/eXNBNJMEWVTzHJ7SfyWXBOzMBC
         9Jk1YtaUvtI2+OTtL/symzFeLqcCJutdVhBprtKJOsy+8wGMhx5fM6INBub6JYXSBr
         poFzVFQsSUXP0CahBvSgr0ILvoWp3/1pcst7pUMEqwpSsuWcWfzuOrDKVK8zZ7bPnx
         nrF2v8hWkOLo22ZieF41CdQBkpq3Mq6CzDSVy60o5Nbax2x5nKuqxKrcud7T53dFB5
         Zvj2eA848ZJAA==
Date:   Mon, 30 May 2022 21:23:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ap420073@gmail.com>
Subject: Re: [PATCH net] macsec: fix UAF bug for real_dev
Message-ID: <20220530212338.7a7d4145@kernel.org>
In-Reply-To: <20220528093659.3186312-1-william.xuanziyang@huawei.com>
References: <20220528093659.3186312-1-william.xuanziyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 May 2022 17:36:59 +0800 Ziyang Xuan wrote:
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -107,6 +107,7 @@ struct pcpu_secy_stats {
>  struct macsec_dev {
>  	struct macsec_secy secy;
>  	struct net_device *real_dev;
> +	netdevice_tracker dev_tracker;

You need to add kdoc for @dev_tracker.
