Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BF0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 14:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349469AbiEQOyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349494AbiEQOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:54:08 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D5533A1C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:54:06 -0700 (PDT)
Message-ID: <d9964d97-d692-5f26-3789-f5c9e8fc810f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652799244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuiXOz92GELRu+TD6vjbhZEdX2kOuUTBlSV7uf2sVvg=;
        b=q2yFj4k61zZYOsCjFXnc+Uhh1FFZoyKRC1tmhpf1yW6xreTPkOvN++r2QXThV3H/pmDzNX
        9E/YqNAuNMEV6l3XqqQnvd07CLP3XCGsG0R/FYGKtM7l3NmsePJsvlmlr3XKcJwSJs/jHm
        R7m0jfo5v0UMc2ITGmE/4T1f/lxn9BE=
Date:   Tue, 17 May 2022 22:53:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] erofs: do not prompt for risk any more when using big
 pcluster
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zbesathu@gmail.com,
        zhangwen@coolpad.com
References: <20220407050101.12556-1-huyue2@coolpad.com>
 <Yk50Op9SqCF9CVRc@B-P7TQMD6M-0146.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chao Yu <chao.yu@linux.dev>
In-Reply-To: <Yk50Op9SqCF9CVRc@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/7 13:18, Gao Xiang wrote:
> On Thu, Apr 07, 2022 at 01:01:23PM +0800, Yue Hu wrote:
>> The big pluster feature has been merged for a year, it has been mostly
>> stable now.
>>
>> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
