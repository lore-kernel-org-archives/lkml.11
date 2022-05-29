Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC470C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 May 2022 07:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiE2HMt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 May 2022 03:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiE2HMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 03:12:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CE8FD4B
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 00:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74CBAB80A2C
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B688C385A9;
        Sun, 29 May 2022 07:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653808361;
        bh=jSg2i6Fv64cazvRJ/QybIFUdNSfT2GdaxWk7bR2XZh4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bD14cGnjEKnU6GfaB/zn6Us2qcXxd99vJGlGJep5JZ5lvZch300Z+u2M9bLGgdzop
         Z9dBgiCbgfwivFAktAOTZIxQ0W/+IRlnWZ9LxUcYQ9NL8Op3P9c7mJScb4lTv7INTo
         flD+B3JAXzkvwAjN1VRmm2ZfhqrDaK8dhkvPX5Ieuia9Yk1qMSkaLJVtv1Qz3Ya0YC
         zaZSznTWlMyeNgzuFRfPcXfCOeoEzJZEyAlqKN0uN8CIjbXhILYceiWhBpB+SMprle
         5SEvGdEgtjOnvjDgSa20N0K4uMUpLF89dezGQi9xt4ufhzXQaHjx98ssFrcZhO0eCq
         amKFhqWdr4buA==
Message-ID: <bda6125a-2141-dcfe-d275-720ebae4c7bd@kernel.org>
Date:   Sun, 29 May 2022 15:12:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] erofs: update documentation
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20220527070133.77962-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220527070133.77962-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/27 15:01, Gao Xiang wrote:
>   - refine the filesystem overview for better description of recent
>     new features like FSDAX or Fscache;
> 
>   - add the new `fsid' mount option;
> 
>   - fix some typos.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
