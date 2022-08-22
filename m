Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C5C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 03:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiHVDx3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 23:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiHVDxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:53:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E7C6338
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zTBrQi6tIHnpiZJcLtL9JGqfihQa+Uot5l+YHLsSKrU=; b=yU0c+4dj7PJ4pHovwDZMqOakG5
        kLJ+s38h9D7SfdV41AYLVig5CGyaTJp+yb1rT6ZQZX6pFLW3zQLvGLTNQwY9a3AwRpF6KZayqxf8+
        Itgy2L8nsAbjTkfodDLVLVo1MryD2liICOS8lB7x+TQ0gP4i03iCclgyR3nBQg/wWb80vI8TfMASi
        1oCfmk4ti2SqVOvE0qdrSPALegV6PXL9pF45lK4UyqZQ8AyH0xbDszy0qWubUx5/mLzpqijzzvmkR
        hzR093ck590rou/62nsxjfo8eWRG2AymqJ5FvKSaDEP6kNCDt4iWVY1MoNNKTh2kePf8A9uy9FuZV
        k6+ZlYWg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPyV6-004Y5h-Pd; Mon, 22 Aug 2022 03:53:20 +0000
Message-ID: <f7214c7d-d573-ef4a-413d-28a63d293838@infradead.org>
Date:   Sun, 21 Aug 2022 20:53:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20220819210112.7924-1-rdunlap@infradead.org>
 <87o7wdkkt4.fsf@mpe.ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87o7wdkkt4.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/22 20:40, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> Fix build error when CONFIG_DRM_AMDGPU=m:
>>
>> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>
>> by exporting 'cpu_smallcore_map' just as other per_cpu
>> symbols are exported.
>>
>> drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
>> This is an inline function on powerpc which references
>> cpu_smallcore_map.
>>
>> Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
>> Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")
> 
> That 2nd commit is not in mainline, only linux-next.
> 
> I don't mind merging this fix preemptively, but is that SHA stable?

Felix, Alex, can you answer that, please?

-- 
~Randy
