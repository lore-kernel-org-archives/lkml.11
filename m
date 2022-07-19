Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B4CCA47F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 20:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiGSUmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbiGSUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:41:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78A453D0E;
        Tue, 19 Jul 2022 13:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BE7AB81D3D;
        Tue, 19 Jul 2022 20:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A39C341C6;
        Tue, 19 Jul 2022 20:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658263316;
        bh=ASqW0sMhLeHSDmcyye21xbAuTqb+hfjpCgPOwiNXB7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q3RWjWSIvQbq52mnSYBCzUjNm+UQR7+937YNxLoLppxnXVn4mSYz3ZIkvS4r0TYDe
         HmzRFWrdHIkacoMwhS0mRnj11GEy8ZPObzXoDatX7iODVBuYOIfLrO3mSTXL++dX3m
         hZT6b0ANga6qIhjNNEoYWbDzFyApUp0MoRzJyJr7Gp89kVweM3Fg1NPkEtpVR7Qf0N
         n5dz7X+bG7US2uBnFz6g7vL/Fw9TOFLIXzsxJX6eQEY1f4rV6EW1QFNBq9n0R6X1U3
         euieXm5LP5EVtRmmFSPYQ8TJCGumzetJGRqvvm8iJqxEfLCnoEobuquTelqqoguZvA
         WsFdhKFYm9KZA==
Date:   Tue, 19 Jul 2022 13:41:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     justinpopo6@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, jannh@google.com, jackychou@asix.com.tw,
        jesionowskigreg@gmail.com, joalonsof@gmail.com, pabeni@redhat.com,
        edumazet@google.com, davem@davemloft.net, f.fainelli@gmail.com,
        justin.chen@broadcom.com
Subject: Re: [PATCH 1/5] net: usb: ax88179_178a: remove redundant init code
Message-ID: <20220719134155.409fe0e6@kernel.org>
In-Reply-To: <1658188689-30846-2-git-send-email-justinpopo6@gmail.com>
References: <1658188689-30846-1-git-send-email-justinpopo6@gmail.com>
        <1658188689-30846-2-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 16:58:05 -0700 justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Bind and reset are basically doing the same thing. Remove the duplicate
> code and have bind call into reset.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

drivers/net/usb/ax88179_178a.c:1329:6: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
        u8 *tmp;
            ^
drivers/net/usb/ax88179_178a.c:1328:7: warning: variable 'tmp16' set but not used [-Wunused-but-set-variable]
        u16 *tmp16;
             ^
