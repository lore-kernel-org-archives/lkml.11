Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ECEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 09:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbiCOJJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiCOJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438F81E3F6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD98B61586
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7377DC340E8;
        Tue, 15 Mar 2022 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647335322;
        bh=00Z/aPEqMpUYQEYLBU8TquCbkMu9mw2X8SAwjRv70x4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M6bubW+a6KhUJ/8q1M+IqR9GQQPp9ygnCSmcg1k7QRJskisgwGk7BdLojd/CKBsN6
         SWVQH2nEXSgBI8oVCHdpXR/nxHGHzmHQz2fY5BwogZqtPeZgjtKhTS2IcVOPEMMdHd
         cUl50/L8xVDYSLU4bXkJ4JxyG+DAmZvjXPHF+3/zd0/8M0H3OuR+k3ZzvVnhjgY90l
         YuZgx+hpEkUuFeJexQb87DlZwuCqzPNBB+odhoI79ZVxmAcjqo1jbqbb3isBYFg/sn
         RydA/c56HoKY6Db5JSDIfbnyoLPuT4i1fRZTpqBvn+ZRH1WcO6jlCqOSkGyJajQ3cp
         73wy7RVALBNsQ==
Message-ID: <37668a23-5b56-015b-fb9b-fd8acb0fd9b7@kernel.org>
Date:   Tue, 15 Mar 2022 17:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/11 2:27, Gao Xiang wrote:
> Avoid the unnecessary tail recursion since it can be converted into
> a loop directly in order to prevent potential stack overflow.
> 
> It's a pretty straightforward conversion.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
