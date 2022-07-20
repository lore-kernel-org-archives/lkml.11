Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 01:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbiGTBai (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiGTB3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:29:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678FA18E;
        Tue, 19 Jul 2022 18:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E636176F;
        Wed, 20 Jul 2022 01:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222B8C341C6;
        Wed, 20 Jul 2022 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658280014;
        bh=97zWpk5yUWe88ABEivPo5Eie7k5uYx67CUHSfhCBGyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2crBdZmLANv8EljFfcvv9e29EChpyzV5e/iMg25XU31n2Hk49LCE7TVcto8md1Kw
         buQ5A1mGFdahklc7VtJCPJAySGUmEJ/tpkN8Cgi68pHuJZaJBfUdBVvqnQBqo6J0Gr
         l1/69+KXdz4ntmXlYtypHmoHNj7EB/DXon9D/3k5+KGY9vgxMebIzi9P+b96BfDApM
         QpUsi/xQsPptTveQ9Y53Ed9rJOk5j1Cm9u4cfT/xgpLCWBgP4PfrzB/5NMe1OAmbz7
         +xTmU82/YzeL8mmD8jaT0WFSU2zFdQr9cOiM1QNxBD9DGZV9X1+M0KELUlWvBgKCZm
         wpcZrJqEc7P1Q==
Date:   Tue, 19 Jul 2022 18:20:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: llc: Fix comment typo
Message-ID: <20220719182013.45497a1a@kernel.org>
In-Reply-To: <20220716044139.43330-1-wangborong@cdjrlc.com>
References: <20220716044139.43330-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 12:41:39 +0800 Jason Wang wrote:
> Subject: [PATCH] net: llc: Fix comment typo
> Date: Sat, 16 Jul 2022 12:41:39 +0800
> X-Mailer: git-send-email 2.35.1
> 
> The double `all' is duplicated in the comment, remove one.

The date on your patches is still broken.
