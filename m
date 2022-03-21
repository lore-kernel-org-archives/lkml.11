Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39EAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 21:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiCUVTC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiCUVS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:18:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C61C7F0F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 14:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D9E7B819FE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABDCC340EE;
        Mon, 21 Mar 2022 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647897444;
        bh=6L2yOiqbI0wYLvAFSBSCd4cDDkO6ZIeuM8uDUM+4+CY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=niJ3shjAgQFM7/OSL9LQ4Btdhn5mEf9tmknoi95NAj4cz1Nln/B0BzQNVILdS4Luy
         c8IXirCV6uqreSeV88wmE+lj/pFeJIhRnETOWfAsyRbx5HE0nkuURYlirD6pnynxsl
         9piDHnvloZceoASW1Bcyo8b1rPYsTT0Qd/Iak9m8=
Date:   Mon, 21 Mar 2022 14:17:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: add same penalty is enough to get
 round-robin order
Message-Id: <20220321141723.39dca650477d4d9075e6e35a@linux-foundation.org>
In-Reply-To: <20220123013537.20491-1-richard.weiyang@gmail.com>
References: <20220123013537.20491-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone please help review this series?

Thanks.
