Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 12:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbiDKMPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiDKMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18F40A05;
        Mon, 11 Apr 2022 05:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 120486160E;
        Mon, 11 Apr 2022 12:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C31C385A3;
        Mon, 11 Apr 2022 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649679212;
        bh=BtDcqZfnlp8Xkcj5jZLl04TlgfDxDdLMfrvNcg808r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o60TzXSOaE1PRWWE/lj3alD1vYrBX6RKYZHXuP5Fq4zwsU0ZwCuVaNyN9cPf0UB1W
         oNt6/19vl58YrDnH+TuAaMdkNTxldbAujcizDskfxfAzHhaw2Ebqzn8hRI9WtnjCUp
         5j4H92+JVUJ40IZAExDizDA4+TeS5j5p+yUfYW+jTbW9v2LBK+vVGV39/2T+kY7znG
         1fvwL3nIbJEZcrj0YJncNuiRs64h0iWOuuPiSVLTmfcuYYpfljmMkspa/0BwAY10X2
         f0fHlUx2CxMNuAn6nIcZOKl3ZMnFrOkN7t2rEYt8iejTOMW7yfz9A2h7la7dYNKMUB
         hJqlFK3ySrDWw==
Date:   Mon, 11 Apr 2022 17:43:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: bestcomm: Prepare cleanup of powerpc's
 asm/prom.h
Message-ID: <YlQbaM8Rz8GF4WyC@matsya>
References: <f98acba303489bdf003e7256460696225b00702e.1648833428.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f98acba303489bdf003e7256460696225b00702e.1648833428.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-04-22, 11:54, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h

Applied, thanks

-- 
~Vinod
