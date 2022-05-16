Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8FC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 17:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344455AbiEPRur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344431AbiEPRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:50:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269C37AAA;
        Mon, 16 May 2022 10:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E23F1CE1724;
        Mon, 16 May 2022 17:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD10C385AA;
        Mon, 16 May 2022 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652723433;
        bh=OxnXrmpy/euBq1gL/d7UIEXDtCB6uChBJFEOviVhpJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHRA8Ko/n2Ag0C/Ri4AxHFXblACxAceyxOxDrx1ZIrU/MjE4XKYlkWaENFIRdBYmH
         Vzjv/MmITdI908dUKA3I34/4HoLTWJjG86tR3s6S8i4NVW2tBBhiDVFBFdTw7nQ9Si
         v/pR7Ljy885udJU9MgTr1PE0t6W2eWu22iI4Y3O5mIDd6AXynFfkvP1GcpD+5sdmZi
         Ij99h6BWoX/zuyoyUOCMzHJYXCW5KqhiOCEz6mi0kLkDtQuzkViT8mnIAJHgmjXPB4
         E3VnW6lAGC9OTcKwdE4HwZbZgss71E3KMPpO2/i5nvoYZrKwAOwT//QTA0pDDpfIO7
         k+yZKWR1I9xXA==
Date:   Mon, 16 May 2022 23:20:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn
Subject: Re: [PATCH V2] dmaengine: idxd: Remove unnecessary synchronize_irq()
 before free_irq()
Message-ID: <YoKO5RFQVsgGSwqE@matsya>
References: <YoI2ZRm3irWmqZDg@matsya>
 <20220516115412.1651772-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516115412.1651772-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-05-22, 11:54, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Calling synchronize_irq() right before free_irq() is quite useless. On one
> hand the IRQ can easily fire again before free_irq() is entered, on the
> other hand free_irq() itself calls synchronize_irq() internally (in a race
> condition free way), before any state associated with the IRQ is freed.

You should not have missed Dave's ack. I have added that and pushed

-- 
~Vinod
