Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC78C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 13:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiDFNyc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiDFNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:52:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30C3D6FFE;
        Tue,  5 Apr 2022 18:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A93DB8203A;
        Wed,  6 Apr 2022 01:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626D9C385A0;
        Wed,  6 Apr 2022 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649208403;
        bh=yJUkzJ/EKyf8PlyHyI5tKyWRwcgeyxQU+NZ1LoKG+vM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A67hvJf1WQOl0FRiyzVu3IF9JiybuDASSlOmGwGrHouCCOVLRcH6aayruhoje5i76
         EfHq+sOQPLvaQdiYiOLhF4n4yfZmRJsqkxHmvAeQUYjxw4EgnUpMDyao89TYHne/Tz
         VYE6trXKmjyVls0jSKN05hJxqPMaGb5E15TD9dwQ8vQ3SszSD8LW+7C6176x4CtQrI
         VDB1xYSOh616c3ewbzi74UH/po4whOYsW9gDutA97LLAE8aFydFouD24xs0bzH/yoc
         3LCRYZx/uzzivR8bfn0NgMXFey+iSKxEXIhTtySBjvia7sEf4srtlK+NwaGxrr8avs
         4mZi0yfD9P3aQ==
Date:   Tue, 5 Apr 2022 18:26:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: remove an unneed NULL check on list iterator
Message-ID: <20220405182641.08cd18ff@kernel.org>
In-Reply-To: <20220405002256.22772-1-xiam0nd.tong@gmail.com>
References: <20220405002256.22772-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Apr 2022 08:22:56 +0800 Xiaomeng Tong wrote:
>  struct pci_dev *qed_validate_ndev(struct net_device *ndev)
>  {
> -	struct pci_dev *pdev = NULL;
> +	struct pci_dev *pdev;
>  	struct net_device *upper;

Please keep the longest-to-shortest ordering of variable declaration
lines.
