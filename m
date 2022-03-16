Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF88C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 02:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353369AbiCPCx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiCPCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:53:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FCA5C354
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 552E9CE1D8A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB39C340E8;
        Wed, 16 Mar 2022 02:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647399160;
        bh=vHF98M61qDvZvLd0Uk5WVb7MVf1iLXSrASw3qtRoIVA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tKWDHvKMbSHVF8CZ8BI+lhJz11QXYzyz+gaRMKP15LiGXLPghlXr+9lFvUU0LLzMs
         VWBNwJk3KRWDCYGGfocp9nmOf5YL0P79iBeFzU9OCcnKSLArB0mrEsbUDxAyJsZEKc
         OfbuVZtm4qEnMYL2suTqFDhx5WL60VEJkt1EU3Y6yXDp6HAkMnPlfox2G3w3LmCdJI
         nc2qDun6fA7DEK17fAD2BtJR2nBGBHw6UDjnJHEIwb1OGFjpuhpLfVthObtv/LLY+8
         zkGneSGTfyBtlNICyAoSYG4fmbeqxAWQT3Q958y1SIf0395zlc5jlFKN0ZHGANmEhi
         JNf6sgkDFgL3g==
Message-ID: <e3611a21-cbed-74c4-e596-e0e628de9b70@kernel.org>
Date:   Wed, 16 Mar 2022 10:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] erofs: support read directory inodes with metabuf
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220316012246.95131-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/16 9:22, Gao Xiang wrote:
> Previously, directory inodes are directly handled with page cache
> interfaces.
> 
> In order to support sub-page directory blocks and folios, let's
> convert them into the latest metabuf infrastructure as well and
> this patch addresses the readdir case first.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
