Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D010C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 00:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiERAji (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 20:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiERAjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:39:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8B3D1CA;
        Tue, 17 May 2022 17:39:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L2vJM1qpTz4xZ2;
        Wed, 18 May 2022 10:39:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652834372;
        bh=PfasWlhYL5IIEatPGqyd0PllM8n5gWkCvmvKfOjR5ZI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ifBigZ+VFYy/C+eimo7bpL5w+3/z23uyazvVk5US29tdXqfEiyiE2kgsivrZ9PIIY
         xi0/+sPtH+wVDTUG0qAjQJTiIjqyDqlL2IbsUzxiu+s+dCJ4zWZp+Ehr10/1HqDsYt
         hEKGFpjk44MjU3NvI8HBJAVNkEuJSlxBdnD/xv1GMNgSd69NNeAHvGIltaDYCpZLAr
         uq0Vu4JdKVZ4PcikfUl4RGDPutZ8MoQlrUs82K/KMzD7oqdCZepJvmEPNAhwA6RjgK
         os8uDWp7ExAUFBZdGl8wH36Vnq/WpSfhCyHnbhrrSltUexy+gwulzJLOZshcUK0aCG
         VuB3+hsPMHw2A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: unexport csum_and_copy_{from,to}_user
In-Reply-To: <YoQcNkB6R/E3vf51@zeniv-ca.linux.org.uk>
References: <20220421070440.1282704-1-hch@lst.de>
 <YoQcNkB6R/E3vf51@zeniv-ca.linux.org.uk>
Date:   Wed, 18 May 2022 10:39:17 +1000
Message-ID: <87y1yzoeru.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> On Thu, Apr 21, 2022 at 09:04:40AM +0200, Christoph Hellwig wrote:
>> csum_and_copy_from_user and csum_and_copy_to_user are exported by
>> a few architectures, but not actually used in modular code.  Drop
>> the exports.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
>
> Not sure which tree should it go through - Arnd's, perhaps?

It's already in akpm's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-nonmm-stable&id=6308499b5e99c0c903fde2c605e41d9a86c4be6c

cheers
