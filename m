Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12587C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 10:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiCLKcA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiCLKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A823C0F4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbc2DdTz4xcq;
        Sat, 12 Mar 2022 21:30:52 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, tyreld@linux.ibm.com,
        Hangyu Hua <hbh25y@gmail.com>, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220302021959.10959-1-hbh25y@gmail.com>
References: <20220302021959.10959-1-hbh25y@gmail.com>
Subject: Re: [PATCH v2] powerpc: kernel: fix refcount leak in format_show()
Message-Id: <164708098533.827774.691952258403804628.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 10:19:59 +0800, Hangyu Hua wrote:
> Refcount leak will happen when format_show returns failure in multiple
> cases. Unified management of of_node_put can fix this problem.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: kernel: fix refcount leak in format_show()
      https://git.kernel.org/powerpc/c/d601fd24e6964967f115f036a840f4f28488f63f

cheers
