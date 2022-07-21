Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC40CC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 18:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiGUShY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiGUShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F98CC98;
        Thu, 21 Jul 2022 11:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C320761FFE;
        Thu, 21 Jul 2022 18:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01AEC3411E;
        Thu, 21 Jul 2022 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658428638;
        bh=KMJ+cz8bRY67c/ISmU+SmPO7kPuM/jdFMnIpyBi74dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0PDRxZTTh0c9u2oE4LyAOgLEu0hk1ZG7pOEQsdz3Jpm4xi/Xn9w0zWfHOgWoBrVf
         n4YOzfooT8zHtnv6xQeOGrpGNwPfa7MweYVfSqbHWDXYjt5luk5qbQEnbyGx61zYiD
         xuXC4GFHTP3vT5YyFFPV9SY3V79E+tUOvUg+UQrg=
Date:   Thu, 21 Jul 2022 20:37:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronald Warsow <rwarsow@gmx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.18 000/231] 5.18.13-rc1 review
Message-ID: <Ytmc2t8FnbwAVMKU@kroah.com>
References: <1ca489cc-491d-f78f-5743-fd47d6c98efb@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca489cc-491d-f78f-5743-fd47d6c98efb@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 05:33:48PM +0200, Ronald Warsow wrote:
> hallo Greg
> 
> 5.18.13-rc1
> 
> compiles here with a lot of warnings on an x86_64
> (Intel i5-11400, Fedora 36)
> 
> warnings all over the tree like this:
> ...
> arch/x86/crypto/twofish-x86_64-asm_64.o: warning: objtool:
> twofish_enc_blk()+0x7b2: 'naked' return found in RETPOLINE build
> arch/x86/crypto/twofish-x86_64-asm_64.o: warning: objtool:
> twofish_dec_blk()+0x7b2: 'naked' return found in RETPOLINE build
> ...
> 
> patch was applied to an clean 5.18.12
> 
> is it just me ?

Should now be resolved in -rc3.  If not, please let me know.
