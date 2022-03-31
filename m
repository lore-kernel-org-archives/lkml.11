Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D69C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 12:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiCaMlm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiCaMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:41:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29213AA3B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:39:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KTjYd4NYVz4xXx;
        Thu, 31 Mar 2022 23:39:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1648730390;
        bh=mtQYRav07C0gt+IZBOPdCcIdZ3AXyNuFaeKrCabS2Gw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lchCe3cPsJx5ZRe3ABIJSBcRS0xkKQe86HweMJDbtrEy4QskxSwqxeGC1NCTqGRUZ
         BiHsG+wZvPHWTemDblhKRuvhaoHkHPbifCWHjISXT78VGEble//8OxHvznzaw5CI+A
         DU1My+bjmb4xvu/jgzKcIU86vU/8KMwoDOYWD3aL6ILnoqdseLRIWzVuDhzHKTDjlD
         JrxWq0eDZLbdnrQAL95aCz0YTjO2pwxTZDswHQXztZJPuqVl6rGyp+HnaIrwQ1Vroo
         ONpTbW4Ybn8dn7RPsjdVoDyQuAqfoqSvrzVLYZHscHNseCW7R/dyzTxYh4XfxshjxO
         GnpYGSGh1k9cA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/vas: use default_groups in kobj_type
In-Reply-To: <20220329142552.558339-1-gregkh@linuxfoundation.org>
References: <20220329142552.558339-1-gregkh@linuxfoundation.org>
Date:   Thu, 31 Mar 2022 23:39:45 +1100
Message-ID: <87h77efg8e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the pseries vas sysfs code to use default_groups field
> which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Haren Myneni <haren@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
> Note, I would like to take this through my driver-core tree for 5.18-rc2
> as this is the last hold-out of the default_attrs field.  It "snuck" in
> as new code for 5.18-rc1, any objection to me taking it?

No objection, please take it via your tree.

cheers
