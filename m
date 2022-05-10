Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A7BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 19:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiEJTRt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345849AbiEJTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:17:44 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4F2609C0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:17:41 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0CCD124002E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1652210260; bh=ytrK2CBdoNyq3TQUxDwxGqNP998kUeZVBv6SkMgZ8c4=;
        h=From:To:Cc:Subject:Date:From;
        b=SpSo+RIS5AqPkBnKIFrzjJFRU5pxj3UqMS5aNbCZCDfZ8/O1PugZQAiYI4JjSu52g
         vSNJhDlT0G7EwPsvVLoqhoAg496KAdm7fDVPeeYwuQ4sJcebe9XKNvoKtmdSoy5aX+
         JwF6Hb2X5xeMi0mqZrcKbT0aCVGUGRq2gktcAyj3+GxRIBrG4T8xZGM5nJhoe+OhjF
         4r9O9GJWiAkgr2DfWL3TXVn060CZrDCrcmdMzFXbT5qjAFRNvhHF74dlrwMf9cDmlU
         CfuQ2fR35AUBAA3xvdec29Rkkkm8CpvE8GDz1sjLPd7IJAFYTD7UsZ0cK+qvUTBERU
         twvuU9VRuwzwQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4KySV871Pqz6tnP;
        Tue, 10 May 2022 21:17:36 +0200 (CEST)
From:   Manuel Ullmann <labre@posteo.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Manuel Ullmann <labre@posteo.de>,
        Igor Russkikh <irusskikh@marvell.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        regressions@lists.linux.dev, davem@davemloft.net,
        ndanilov@marvell.com, kuba@kernel.org, edumazet@google.com,
        Jordan Leppert <jordanleppert@protonmail.com>,
        Holger Hoffstaette <holger@applied-asynchrony.com>,
        koo5 <kolman.jindrich@gmail.com>
Subject: Re: [PATCH v6] net: atlantic: always deep reset on pm op, fixing up
 my null deref regression
References: <87bkw8dfmp.fsf@posteo.de>
        <b140c37fe1aac315e07464dd6a2d7a8f463e6fe4.camel@redhat.com>
Date:   Tue, 10 May 2022 19:17:56 +0000
In-Reply-To: <b140c37fe1aac315e07464dd6a2d7a8f463e6fe4.camel@redhat.com>
        (Paolo Abeni's message of "Tue, 10 May 2022 10:37:24 +0200")
Message-ID: <87r151gpsr.fsf@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> writes:

> On Sun, 2022-05-08 at 00:36 +0000, Manuel Ullmann wrote:
>> [...]
>
> For future submission, please always specify the target tree (which is
> -net in this case). No need to resubmit: I'm applying it.
>
> Thanks,
>
> Paolo

Ah, okay. So next branches are reserved for new changes, while non-next
may be targeted by fixups or at least regression fixes. I can't recall a
definition for this in the documentation, but that might be me. I'll
keep this in mind for the future. Thanks for applying it and bearing
with me.

Regards,
Manuel
