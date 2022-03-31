Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8613FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 12:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiCaNAl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiCaNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:00:32 -0400
Received: from louie.mork.no (louie.mork.no [IPv6:2001:41c8:51:8a:feff:ff:fe00:e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A718382A;
        Thu, 31 Mar 2022 05:58:36 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:c9f:8600:0:0:0:1])
        (authenticated bits=0)
        by louie.mork.no (8.15.2/8.15.2) with ESMTPSA id 22VCwErm206850
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 13:58:16 +0100
Received: from miraculix.mork.no ([IPv6:2a01:799:c9f:8602:8cd5:a7b0:d07:d516])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.15.2/8.15.2) with ESMTPSA id 22VCwC1b3975823
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:58:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1648731494; bh=3qad0vu847N501JVj+B9zfqjiTiuw/ACV2x6SxDvb2M=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=Z3DvLyPGhXpJCOh58KXP7rFdbDdw8HiozWFs+fYFn8M1SYJG4TV2gRAl5a4JH3Hvc
         wNiZBwjXwjqUdnf8vvvB0pLSh8ECgbd0QDLLmJF1xZppE0ovaJ0uvEq+bk/rucMnIF
         OrkQrrBCVPXZWHdS5pm8OwWCxXFXNNLbasYwjtHs=
Received: (nullmailer pid 178357 invoked by uid 1000);
        Thu, 31 Mar 2022 12:58:12 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Qing Wang <wangqing@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: remove duplicate assignment
Organization: m
References: <1648728494-37344-1-git-send-email-wangqing@vivo.com>
Date:   Thu, 31 Mar 2022 14:58:12 +0200
In-Reply-To: <1648728494-37344-1-git-send-email-wangqing@vivo.com> (Qing
        Wang's message of "Thu, 31 Mar 2022 05:08:14 -0700")
Message-ID: <87sfqygty3.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.5 at canardo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qing Wang <wangqing@vivo.com> writes:

> netdev_alloc_skb() has assigned ssi->netdev to skb->dev if successed,
> no need to repeat assignment.

Thanks.

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>
