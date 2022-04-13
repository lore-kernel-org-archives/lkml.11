Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DFCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 06:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiDMGpE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 02:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiDMGpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:45:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20522C11C;
        Tue, 12 Apr 2022 23:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B225B820FE;
        Wed, 13 Apr 2022 06:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9771DC385A6;
        Wed, 13 Apr 2022 06:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649832159;
        bh=Z7OFrPj0bX5MvKFUOMLJsvOjs12AWG7MQ65iVC8WD6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g06SzperoHCgZwa8/92u6JZAJDVi5tdqh7Zi7wvdG190Y7izLVILWrIQh3G9mrep5
         6bTeAhJ7+8Xhf0aTJbL5KLR7J3w1vqzcxvtvTgIpIfK6PT3MIjX178uqFYjQLLPUSD
         YpUCS9MLuHbyKcK1cmkVQNQoazh5VwS+dpx4nsSfYYbdahfgveMCRdSCoWu2SW7zkg
         nOWHQhHyn+LNh8Ndc73bX0n3i3NcsrISrh9L76a0dWJn7CmF70HOWah58Zd/EO+HmQ
         rxm4hAX2EtR7PvPjBaOpo0sK07d1gWeAxF8fGL/wsYoq1EHoiZAAB1yGuGJaEVd5Mq
         o1uPF7aYF40Ow==
Date:   Wed, 13 Apr 2022 12:12:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] dt-bindings: phy: Fix uniphier descriptions
Message-ID: <YlZw2jUmLjWuL2SG@matsya>
References: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-03-22, 19:55, Kunihiko Hayashi wrote:
> This series fixes dt-schema descriptions for all PHYs implemented in
> UniPhier SoCs.

Applied, thanks

-- 
~Vinod
