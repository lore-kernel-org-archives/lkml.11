Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19000C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 10:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiC1KjD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 06:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiC1KjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:39:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4036170
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:37:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRpzc0w98z4xLS;
        Mon, 28 Mar 2022 21:37:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1648463837;
        bh=j+k2BDfbdQx4zYpgl58V8K4qKN8q+JC6OELJvVduZdk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BN2Ccu9ny+Pu9NAS6ObsluDgsrxVhj9MCOS7BRzf1KuSQETEzKLrUgB7uPhYE5rYB
         ZQeod4N4q5q+hqeJOjp+U16rLaOSyPrA7W4eCZUnTgYZPmnscAY6XddB274kKpHED8
         0i/sLbGDzq6GFxaGDHKDLCV/PeG76NwNxkqR2U7899Q/uYditTkyUQsPSadeW/FEjT
         VSZ+wGt7nqjYKmbwayd/kSptFNiwgkI8TzmUm9YxcM7xcnQteSjZLpnLk5PkACCyWk
         satOHFvYM3ZjfdHJJYWAvsXL1C/5aSIlt5Lyzi3ZemU+uIAvUi8ILTWBwAFvGX4slj
         e5J0r/3bpn/TQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        songyuanzheng@huawei.com
Subject: Re: [PATCH v4 1/2] Revert "powerpc: Set max_mapnr correctly"
In-Reply-To: <b2ff771c-01ef-3f14-f22d-9248735fdc77@huawei.com>
References: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
 <b2ff771c-01ef-3f14-f22d-9248735fdc77@huawei.com>
Date:   Mon, 28 Mar 2022 21:37:15 +1100
Message-ID: <87sfr2fjms.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> Hi maintainers=EF=BC=8C
>
> I saw the patches has been reviewed[1], could they be merged?

Maybe I'm just misreading the change log, but it seems wrong that we
need to add extra checks. pfn_valid() shouldn't return true for vmalloc
addresses in the first place, shouldn't we fix that instead? Who knows
what else that might be broken because of that.

cheers
